#!/bin/bash

#-------------------------------------------------------------------------------
# DESCRIÇÃO:
#   Este script busca dados meteorológicos de wttr.in, analisa a resposta JSON
#   e imprime uma linha de status concisa com ícone do tempo, temperatura,
#   índice UV e precipitação (se houver).
#
# DEPENDÊNCIAS:
#   - bash (v4.0+)
#   - curl
#   - jq
#   - bc
#-------------------------------------------------------------------------------

# Garante que o script pare se um comando falhar
set -e

# --- Tabelas de Conversão e Símbolos ---

# Mapeia o código da API (WWO_CODE) para uma descrição legível
declare -A WWO_CODE=(
    ["113"]="Sunny"
    ["116"]="PartlyCloudy"
    ["119"]="Cloudy"
    ["122"]="VeryCloudy"
    ["143"]="Fog"
    ["176"]="LightShowers"
    ["179"]="LightSleetShowers"
    ["182"]="LightSleet"
    ["185"]="LightSleet"
    ["200"]="ThunderyShowers"
    ["227"]="LightSnow"
    ["230"]="HeavySnow"
    ["248"]="Fog"
    ["260"]="Fog"
    ["263"]="LightShowers"
    ["266"]="LightRain"
    ["281"]="LightSleet"
    ["284"]="LightSleet"
    ["293"]="LightRain"
    ["296"]="LightRain"
    ["299"]="HeavyShowers"
    ["302"]="HeavyRain"
    ["305"]="HeavyShowers"
    ["308"]="HeavyRain"
    ["311"]="LightSleet"
    ["314"]="LightSleet"
    ["317"]="LightSleet"
    ["320"]="LightSnow"
    ["323"]="LightSnowShowers"
    ["326"]="LightSnowShowers"
    ["329"]="HeavySnow"
    ["332"]="HeavySnow"
    ["335"]="HeavySnowShowers"
    ["338"]="HeavySnow"
    ["350"]="LightSleet"
    ["353"]="LightShowers"
    ["356"]="HeavyShowers"
    ["359"]="HeavyRain"
    ["362"]="LightSleetShowers"
    ["365"]="LightSleetShowers"
    ["368"]="LightSnowShowers"
    ["371"]="HeavySnowShowers"
    ["374"]="LightSleetShowers"
    ["377"]="LightSleet"
    ["386"]="ThunderyShowers"
    ["389"]="ThunderyHeavyRain"
    ["392"]="ThunderySnowShowers"
    ["395"]="HeavySnowShowers"
)

# Símbolos para condições diurnas
declare -A WEATHER_SYMBOL_WI_DAY=(
    ["Unknown"]=""
    ["Cloudy"]=""
    ["Fog"]=""
    ["HeavyRain"]=""
    ["HeavyShowers"]=""
    ["HeavySnow"]=""
    ["HeavySnowShowers"]=""
    ["LightRain"]=""
    ["LightShowers"]=""
    ["LightSleet"]=""
    ["LightSleetShowers"]=""
    ["LightSnow"]=""
    ["LightSnowShowers"]=""
    ["PartlyCloudy"]=""
    ["Sunny"]=""
    ["ThunderyHeavyRain"]=""
    ["ThunderyShowers"]=""
    ["ThunderySnowShowers"]=""
    ["VeryCloudy"]=""
)

# Símbolos para condições noturnas
declare -A WEATHER_SYMBOL_WI_NIGHT=(
    ["Unknown"]=""
    ["Cloudy"]=""
    ["Fog"]=""
    ["HeavyRain"]=""
    ["HeavyShowers"]=""
    ["HeavySnow"]=""
    ["HeavySnowShowers"]=""
    ["LightRain"]=""
    ["LightShowers"]=""
    ["LightSleet"]=""
    ["LightSleetShowers"]=""
    ["LightSnow"]=""
    ["LightSnowShowers"]=""
    ["PartlyCloudy"]=""
    ["Sunny"]=""
    ["ThunderyHeavyRain"]=""
    ["ThunderyShowers"]=""
    ["ThunderySnowShowers"]=""
    ["VeryCloudy"]=""
)

# --- Lógica do Script ---

# 1. Obter os dados do tempo em formato JSON
# A URL pode ser personalizada, ex: "https://wttr.in/Maringa?format=j1"
weather_data=$(curl -s "https://wttr.in/?format=j1")

# Se a requisição falhar, o JSON estará vazio.
if [[ -z "$weather_data" ]]; then
    echo "Erro: Não foi possível obter os dados do tempo."
    exit 1
fi

# 2. Extrair os dados necessários do JSON usando jq
current_condition=$(echo "$weather_data" | jq '.current_condition[0]')
astronomy=$(echo "$weather_data" | jq '.weather[0].astronomy[0]')

weather_code=$(echo "$current_condition" | jq -r '.weatherCode')
temp_c=$(echo "$current_condition" | jq -r '.temp_C')
uv_index=$(echo "$current_condition" | jq -r '.uvIndex')
precip_mm=$(echo "$current_condition" | jq -r '.precipMM')

# Para determinar se é dia ou noite
sunrise_str=$(echo "$astronomy" | jq -r '.sunrise') # Ex: "07:04 AM"
sunset_str=$(echo "$astronomy" | jq -r '.sunset')   # Ex: "06:09 PM"
# Usamos a hora local da observação para a comparação
obs_time_str=$(echo "$current_condition" | jq -r '.observation_time') # Extrai "HH:MM PM/AM"

# 3. Determinar se é dia ou noite
# Convertemos os horários para segundos para uma comparação numérica segura
current_time_sec=$(date +%s -d "$obs_time_str")
sunrise_sec=$(date +%s -d "$sunrise_str")
sunset_sec=$(date +%s -d "$sunset_str")

is_day=false
if (( current_time_sec >= sunrise_sec && current_time_sec < sunset_sec )); then
    is_day=true
fi

# 4. Obter a descrição e o símbolo do tempo
weather_description=${WWO_CODE[$weather_code]:-"Unknown"} # Usa "Unknown" como padrão

weather_symbol=""
if $is_day; then
    weather_symbol=${WEATHER_SYMBOL_WI_DAY[$weather_description]}
else
    weather_symbol=${WEATHER_SYMBOL_WI_NIGHT[$weather_description]}
fi

# 5. Construir a string de saída
output_string="${weather_symbol} ${temp_c}°C"

if [[ "$uv_index" > 0 ]]; then
    output_string+=" 󱟾 ${uv_index}"
fi

# Adicionar precipitação somente se for maior que 0.
# Esta nova seção compara a parte inteira e a decimal separadamente
# para evitar a dependência do comando 'bc'.

# Extrai a parte antes do ponto decimal. Ex: "1.2" -> "1"
integer_part=${precip_mm%%.*}
# Extrai a parte depois do ponto decimal. Ex: "1.2" -> "2"
decimal_part=${precip_mm#*.}

# Se não houver ponto decimal (ex: "5"), as duas partes serão idênticas.
# Nesse caso, consideramos a parte decimal como 0.
if [[ "$integer_part" == "$decimal_part" ]]; then
    decimal_part="0"
fi

# O valor é > 0 se a parte inteira for > 0 OU a parte decimal for > 0.
if (( integer_part > 0 || decimal_part > 0 )); then
    output_string+=" 󰖗 ${precip_mm}mm"
fi

# 6. Imprimir a string final
echo "$output_string"
