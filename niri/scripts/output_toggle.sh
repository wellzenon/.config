#!/usr/bin/env bash

ON_STR="on"
OFF_STR="off"

ACTION=""
STATUS_TARGET=""
DO_STATUS=0

# =========================
# Args
# =========================
while [[ $# -gt 0 ]]; do
    case "$1" in
        --on-str) ON_STR="$2"; shift 2 ;;
        --off-str) OFF_STR="$2"; shift 2 ;;
        --status)
            DO_STATUS=1
            if [[ -n "$2" && ! "$2" == --* ]]; then
                STATUS_TARGET="$2"
                shift 2
            else
                shift
            fi
            ;;
        external|internal|notebook)
            ACTION="$1"
            shift
            ;;
        *) echo "Arg inválido: $1"; exit 1 ;;
    esac
done

# =========================
# Parse outputs (simples)
# =========================
mapfile -t OUTPUT_LINES < <(niri msg outputs)

NAMES=()
STATES=()

CURRENT=""
STATE="on"

REGEX_OUTPUT="^Output.*\(([^)]+)\)"
REGEX_INTERNAL="^(eDP|LVDS|MIPI)"

for line in "${OUTPUT_LINES[@]}"; do
    if [[ "$line" =~ $REGEX_OUTPUT ]]; then
        if [[ -n "$CURRENT" ]]; then
            NAMES+=("$CURRENT")
            STATES+=("$STATE")
        fi
        CURRENT="${BASH_REMATCH[1]}"
        STATE="on"
    elif [[ "$line" =~ Disabled ]]; then
        STATE="off"
    fi
done

# último
[[ -n "$CURRENT" ]] && NAMES+=("$CURRENT") && STATES+=("$STATE")

# =========================
# Identificar 2 primeiros
# =========================
INTERNAL_NAME=""
INTERNAL_STATE="off"
EXTERNAL_NAME=""
EXTERNAL_STATE="off"

for i in "${!NAMES[@]}"; do
    name="${NAMES[$i]}"
    state="${STATES[$i]}"

    if [[ "$name" =~ $REGEX_INTERNAL ]]; then
        [[ -z "$INTERNAL_NAME" ]] && INTERNAL_NAME="$name" && INTERNAL_STATE="$state"
    else
        [[ -z "$EXTERNAL_NAME" ]] && EXTERNAL_NAME="$name" && EXTERNAL_STATE="$state"
    fi
done

# =========================
# Regra: precisa ter 2
# =========================
if [[ -z "$DO_STATUS" && ( -z "$INTERNAL_NAME" || -z "$EXTERNAL_NAME" ) ]]; then
    notify-send "Can't toggle output" "Just one output identified, can't turn off all outputs."
    exit 0
fi

# =========================
# Status
# =========================
fmt() {
    [[ "$1" == "on" ]] && echo "$ON_STR" || echo "$OFF_STR"
}

if [[ "$DO_STATUS" -eq 1 ]]; then
    case "$STATUS_TARGET" in
        external) fmt "$EXTERNAL_STATE" ;;
        internal|notebook) fmt "$INTERNAL_STATE" ;;
        *)
            echo "internal: $INTERNAL_NAME"
            echo "internal: $(fmt "$INTERNAL_STATE")"
            echo "external: $EXTERNAL_NAME"
            echo "external: $(fmt "$EXTERNAL_STATE")"
            ;;
    esac
    exit 0
fi

# =========================
# Toggle com segurança
# =========================
toggle() {
    local name="$1"
    local state="$2"
    local other_name="$3"
    local other_state="$4"

    if [[ "$state" == "on" ]]; then
        if [[ "$other_name" ]]; then
            # se vai desligar e o outro já está desligado -> liga o outro
            if [[ "$other_state" == "off" ]]; then
                niri msg output "$other_name" on
            else
                niri msg output "$name" off
            fi
        fi
    else
        niri msg output "$name" on
    fi
}

case "$ACTION" in
    external)
        toggle "$EXTERNAL_NAME" "$EXTERNAL_STATE" "$INTERNAL_NAME" "$INTERNAL_STATE"
        ;;
    internal|notebook)
        toggle "$INTERNAL_NAME" "$INTERNAL_STATE" "$EXTERNAL_NAME" "$EXTERNAL_STATE"
        ;;
esac
