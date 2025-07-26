#!/bin/bash

# Verifica se o microfone padrão está mudo
is_muted() {
    wpctl get-volume @DEFAULT_SOURCE@ | grep -q 'MUTED'
}

# Obtém o volume do microfone padrão e converte para porcentagem
get_volume() {
    # A saída é como "Volume: 0.70", então pegamos o segundo campo, multiplicamos por 100 e removemos as casas decimais.
    wpctl get-volume @DEFAULT_SOURCE@ | awk '{print $2 * 100}' | xargs printf "%.0f"
}

if is_muted; then
    # Se estiver mudo, exibe "Mudo" e usa a classe CSS "muted"
    echo ' '
else
    # Se não estiver mudo, obtém o volume e exibe
    volume=$(get_volume)
    echo " ${volume}%"
fi
