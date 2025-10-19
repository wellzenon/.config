#!/bin/bash

# IDs dos seus monitores (substitua pelos seus IDs reais)
MONITOR_EXTERNO_ID="HDMI-A-1" # Exemplo: Substitua pelo ID do seu monitor externo
MONITOR_NOTEBOOK_ID="eDP-1" # Exemplo: Substitua pelo ID do monitor do seu notebook
ON_STR="on"
OFF_STR="off"

# Função para obter o estado de um monitor (on/off)
get_monitor_state() {
    niri msg outputs | awk -v target_output="$1" '
        $0 ~ target_output { state = "on"; start = 1 }
        /Disabled/ { state = "off" }
        /^$/ { if ( start ) { 
            start = 0
            print state
        }} 
    '
}

# Função para alternar o estado de um monitor
toggle_monitor() {
    local target_monitor=$1
    local other_monitor=""

    if [ "$target_monitor" == "$MONITOR_EXTERNO_ID" ]; then
        other_monitor=$MONITOR_NOTEBOOK_ID
    else
        other_monitor=$MONITOR_EXTERNO_ID
    fi

    TARGET_STATE=$(get_monitor_state "$target_monitor")
    OTHER_STATE=$(get_monitor_state "$other_monitor")

    if [ "$TARGET_STATE" == "on" ]; then
        # Se o alvo está ligado, tenta desligar
        if [ "$OTHER_STATE" == "on" ]; then
            # Se o outro também está ligado, pode desligar o alvo
            niri msg output "$target_monitor" off
        else
            niri msg output "$target_monitor" off
            niri msg output "$other_monitor" on
        fi
    else
        # Se o alvo está desligado, liga
        niri msg output "$target_monitor" on
    fi

    way-edges -c $HOME/.config/way-edges/niri.jsonc &>/dev/null
}

# Obtém o estado atual e imprime para o Waybar
print_monitor_status() {
    get_state_str() {
        STATE=$(get_monitor_state "$1")
        [[ "$STATE" == "on" ]] && echo "$ON_STR" || echo "$OFF_STR"
    }
    NB_STATE=$(get_monitor_state "$MONITOR_NOTEBOOK_ID")

    if [ "$1" == "notebook" ]; then
        get_state_str "$MONITOR_NOTEBOOK_ID"
        exit 0
    elif [ "$1" == "external" ]; then
        get_state_str "$MONITOR_EXTERNO_ID"
        exit 0
    else
        echo "{\"external\":\"$(get_state_str $MONITOR_EXTERNO_ID)\", \"notebook\":\"$(get_state_str $MONITOR_NOTEBOOK_ID)\"}"
    fi
    
    exit 2
}

while [[ "$#" -gt 0 ]]; do # Enquanto houver argumentos
    case "$1" in
        external)
            toggle_monitor "$MONITOR_EXTERNO_ID"
            pkill -SIGRTMIN+21 waybar
            exit 0
            ;;
        notebook)
            toggle_monitor "$MONITOR_NOTEBOOK_ID"
            pkill -SIGRTMIN+21 waybar
            exit 0
            ;;
        --on-str)
            if [[ -z "$2" ]]; then
                echo "Error: --on-str needs an arg"
                exit 1
            fi
            ON_STR="$2"
            shift
            shift
            ;;
        --off-str)
            if [[ -z "$2" ]]; then
                echo "Error: --on-str needs an arg"
                exit 1
            fi
            OFF_STR="$2"
            shift
            shift
            ;;
        --status)
            print_monitor_status "$2"
            exit 0
            ;;
        *)
            echo "Opção inválida ou argumento inesperado: $1"
            echo "Uso: $0 [--on-str string] [--off-str string] [--status ['external'|'notebook']] 'external'|'notebook'"
            exit 1
            ;;
    esac
done
