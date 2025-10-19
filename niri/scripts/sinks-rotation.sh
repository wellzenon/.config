#!/bin/bash

# Obter uma lista de IDs de todos os sinks de áudio
sink_ids=($(wpctl status | awk '/^Audio/ {audio=1; next}; /Sinks/ {sinks=1; next}; /Sources/ {sinks=0} /^$/ {audio=0}; audio && sinks {gsub(/\./, "", $0); if ($0 ~ "*") {print $3} else {print $2}}'))

# Se não houver sinks, saia
if [ ${#sink_ids[@]} -eq 0 ]; then
  notify-send "Nenhum sink de áudio encontrado."
  exit 1
fi

# Obter o ID do sink padrão atual
current_sink_id=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep -oP '(?<=id )[0-9]+')

# Encontrar o índice do sink atual no array
current_index=-1
for i in "${!sink_ids[@]}"; do
  if [[ "${sink_ids[$i]}" == "$current_sink_id" ]]; then
    current_index=$i
    break
  fi
done

# Calcular o índice do próximo sink (rotacionando para o início se chegar ao fim)
next_index=$(( (current_index + 1) % ${#sink_ids[@]} ))

# Obter o ID do próximo sink
next_sink_id=${sink_ids[$next_index]}

# Definir o próximo sink como padrão
wpctl set-default $next_sink_id

sink_name=$(wpctl status | awk -F '.' -v id="$next_sink_id" 'match($0, " " id "\\. ") { print $2 "." $3}')


notify-send "Saída de áudio alterada" "$sink_name"

