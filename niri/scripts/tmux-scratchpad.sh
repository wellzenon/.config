#!/usr/bin/env bash

# Nome da sessão tmux usada pelo scratchpad
SESSION_NAME="scratch"

# Comando do Ghostty com tmux
GHOSTTY_CMD="ghostty -e tmux attach -t $SESSION_NAME"

# Cria a sessão tmux se não existir
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    tmux new-session -d -s "$SESSION_NAME"
fi

# Verifica se já existe uma janela Ghostty para essa sessão
WINDOW_ID=$(niri msg --json windows | jq -r ".[] | select(.app_id==\"com.terminal.scratch\") | .id")

if [[ -n $WINDOW_ID ]]; then
    # Se a janela estiver aberta → fecha
    niri msg action close-window --id "$WINDOW_ID"
    exit 0
fi

# Se não estiver aberta → abre nova janela com título "scratchpad"
ghostty --class="com.terminal.scratch" --background="2c2d30" --confirm-close-surface="false" -e "tmux new-session -A -s $SESSION_NAME" &
