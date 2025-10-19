#!/bin/bash

# Criar arrays para IDs e nomes dos sinks
mapfile -t sinks < <(wpctl status | awk '
  /^Audio/ {audio=1; next}
  /Sinks/ {sinks=1; next}
  /Sources/ {sinks=0}
  /^$/ {audio=0}
  audio && sinks {
    gsub(/\./,"");          # remove os pontos dos IDs
    if ($0 ~ "*") {id=$3; $1=$2=$3="";} 
    else {id=$2; $1=$2="";}
    sub(/^ +/, "");          # remove espaços à esquerda
    print id "|" $0          # separador "|" entre ID e nome
  }
')

# Se não houver sinks, sair
if [ ${#sinks[@]} -eq 0 ]; then
    notify-send "Nenhum sink de áudio encontrado."
    exit 1
fi

echo $sinks

# Obter o ID do sink atual
current_sink_id=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep -oP '(?<=id )[0-9]+')

# Encontrar índice do sink atual
current_index=-1
for i in "${!sinks[@]}"; do
    id="${sinks[$i]%%|*}"  # extrai ID antes do "|"
    if [[ "$id" == "$current_sink_id" ]]; then
        current_index=$i
        break
    fi
done

# Calcular índice do próximo sink
next_index=$(( (current_index + 1) % ${#sinks[@]} ))

# Obter ID e nome do próximo sink
next_sink="${sinks[$next_index]}"
next_sink_id="${next_sink%%|*}"
next_sink_name="${next_sink#*|}"

# Alternar para o próximo sink
wpctl set-default "$next_sink_id"

# Notificação mostrando o nome do sink ativo
notify-send "Saída de áudio alterada" "$next_sink_name"
