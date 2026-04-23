#!/bin/bash

declare -A sink_icons

sink_icons[0]="󰋋"
sink_icons[1]="󰓃"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --status) DO_STATUS=1; shift ;;
        *) echo "Arg inválido: $1"; exit 1 ;;
    esac
done

# 1. Obter IDs limpando caracteres especiais (incluindo o *)
sink_ids=($(wpctl status -n | awk '/alsa_output.*\[.*\].*/ { gsub(/[^0-9]+/," ", $0); print $1}'))

# Se não houver sinks, saia
if [ ${#sink_ids[@]} -eq 0 ]; then
  notify-send "Nenhum sink de áudio encontrado."
  exit 1
fi

# 2. Obter o ID do sink padrão atual (mais simples via wpctl inspect)
current_sink_id=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | awk '/^id/ {gsub(/[^0-9]+/, "", $0); print }')

# 3. Encontrar o índice do sink atual no array
current_index=-1
for i in "${!sink_ids[@]}"; do
  if [[ "${sink_ids[$i]}" == "$current_sink_id" ]]; then
    current_index=$i
    break
  fi
done

if [[ "$DO_STATUS" -eq 1 ]]; then
  echo ${sink_icons[$current_index]}
  exit 0
fi

# 4. Calcular o próximo índice
next_index=$(( (current_index + 1) % ${#sink_ids[@]} ))
next_sink_id=${sink_ids[$next_index]}

# 5. Definir o próximo sink como padrão
wpctl set-default "$next_sink_id"

# 6. Obter o nome do sink para a notificação
sink_name=$(wpctl status | grep -A 20 "Sinks:" | grep "$next_sink_id\." | sed "s/.*$next_sink_id\. //")

notify-send "Saída de áudio alterada" "$sink_name"
