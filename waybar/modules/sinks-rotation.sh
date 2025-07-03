#!/bin/bash

# Obter uma lista de IDs de todos os sinks de áudio
status=$(wpctl status | awk '/^Audio/ {audio=1; next}; /Sinks/ {sinks=1; next}; /Sources/ {sinks=0} /^$/ {audio=0}; audio && sinks {gsub(/\./, "", $0); if ($0 ~ "*") {print $3 " default"} else {print $2}}')

sink_ids=($(echo "$status" | awk '{print $1}'))

# Se não houver sinks, saia
if [ ${#sink_ids[@]} -eq 0 ]; then
  echo "Nenhum sink de áudio encontrado."
  exit 1
fi

# Obter o ID do sink padrão atual (o que tem um '*')
current_sink_id=$(echo "$status" | awk '/default/ {print $1}')

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
