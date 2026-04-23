#!/bin/bash

# Caminhos dos arquivos
CONFIG_FILE="$HOME/.config/niri/config.kdl"
INCLUDE_LINE='include "sioyek.kdl"'

# Verifica se a linha existe e NÃO está comentada
if grep -q "^$INCLUDE_LINE" "$CONFIG_FILE"; then
    # Se a linha estiver ativa, comenta-a (insere // no início)
    sed -i "s|^$INCLUDE_LINE|// $INCLUDE_LINE|" "$CONFIG_FILE"
else
    # Se a linha estiver comentada, remove o comentário
    # O regex busca a linha que começa com // seguido pelo include
    sed -i "s|^// $INCLUDE_LINE|$INCLUDE_LINE|" "$CONFIG_FILE"
fi
