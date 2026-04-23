#!/bin/bash

# ==========================================
# 1. Avaliação de Estado e Definição de Variáveis
# ==========================================
CURRENT_STATE=$(gsettings get org.gnome.desktop.interface color-scheme)
LIGHT_STR="light"
DARK_STR="dark"

# =========================
# Args
# =========================
while [[ $# -gt 0 ]]; do
    case "$1" in
        --light) CURRENT_STATE="'prefer-dark'"; shift ;;
        --dark) CURRENT_STATE="'default'"; shift ;;
        --light-str) LIGHT_STR="$2"; shift 2 ;;
        --dark-str) DARK_STR="$2"; shift 2 ;;
        --status)
            DO_STATUS=1
            if [[ -n "$2" && ! "$2" == --* ]]; then
                STATUS_TARGET="$2"
                shift 2
            else
                shift
            fi
            ;;
        *) echo "Arg inválido: $1"; exit 1 ;;
    esac
done

if [[ "$DO_STATUS" -eq 1 ]]; then
    if [ "$CURRENT_STATE" = "'prefer-dark'" ]; then
      echo "$DARK_STR"
    else
      echo "$LIGHT_STR"
    fi
    exit 0
fi


if [ "$CURRENT_STATE" = "'prefer-dark'" ]; then
    # Alvo: TEMA CLARO
    GNOME_CS="default"
    GTK_THEME="Adwaita"              # Ajuste para seu tema GTK claro
    NVIM_BG="light"
    KVANTUM_THEME="KvGnome"          # Ajuste para seu tema Kvantum claro
    SIOYEK_BG="1.0 1.0 1.0"          # RGB para fundo Sioyek
    SIOYEK_TXT="0.0 0.0 0.0"         # RGB para texto Sioyek
    NIRI_CURSOR="Bibata-Modern-Classic"
    WALLPAPER="$HOME/.config/wallpapers/Monster Abstract Wallpaper 4k Pc Desktop 5300a.jpg"
    WAY_EDGES_FG="#444"
    WAY_EDGES_BG="#ddd"
else
    # Alvo: TEMA ESCURO
    GNOME_CS="prefer-dark"
    GTK_THEME="Adwaita-dark"         # Ajuste para seu tema GTK escuro
    NVIM_BG="dark"
    KVANTUM_THEME="KvGnomeDark"           # Ajuste para seu tema Kvantum escuro
    SIOYEK_BG="0.1 0.1 0.1"
    SIOYEK_TXT="0.8 0.8 0.8"
    NIRI_CURSOR="Bibata-Modern-Ice"
    WALLPAPER="$HOME/.config/wallpapers/4K-OLED-Backgrounds-for-Desktop.jpg"
    WAY_EDGES_FG="#bbb"
    WAY_EDGES_BG="#222"
fi

killall -SIGUSR1 swaybg
swaybg -m fill -i "$WALLPAPER" &

# ==========================================
# 2. GNOME, Nautilus e Obsidian (GTK4 / Electron)
# ==========================================
# O Nautilus segue nativamente o color-scheme.
gsettings set org.gnome.desktop.interface color-scheme "$GNOME_CS"
# Aplicações GTK3 legadas exigem a mudança explícita do tema GTK:
gsettings set org.gnome.desktop.interface gtk-theme "$GTK_THEME"

# ==========================================
# 4. Neovim (RPC)
# ==========================================
# Localiza todos os sockets do Neovim abertos pelo usuário atual e injeta a mudança de background.
NVIM_SOCKETS=$(find "${XDG_RUNTIME_DIR:-/run/user/$(id -u)}" -name "nvim.*" -type s 2>/dev/null)
for server in $NVIM_SOCKETS; do
    # O uso do '&' processa os sockets em paralelo para evitar travamentos
    nvim --server "$server" --remote-send "<Esc>:set background=$NVIM_BG<CR><F4><F4>" &
done

# ==========================================
# 5. Motor Qt (Kvantum)
# ==========================================
# Assumindo o uso de Kvantum (recomendado para consistência em WMs como Niri/Hyprland).
if command -v kvantummanager &> /dev/null; then
    kvantummanager --set "$KVANTUM_THEME"
fi

# ==========================================
# 6. Sioyek
# ==========================================
# Sioyek não possui hot-reload nativo para o arquivo de configuração.
# O script atualiza o arquivo para que novas instâncias (ou reloads) adotem a cor correta.
SIOYEK_CONF="$HOME/.config/sioyek/prefs_user.config"
if [ -f "$SIOYEK_CONF" ]; then
    # Remove as configurações de cor antigas para evitar duplicação e anexa as novas
    sed -i '/^custom_background_color/d' "$SIOYEK_CONF"
    sed -i '/^custom_text_color/d' "$SIOYEK_CONF"
    echo "custom_background_color $SIOYEK_BG" >> "$SIOYEK_CONF"
    echo "custom_text_color $SIOYEK_TXT" >> "$SIOYEK_CONF"
fi

# ==========================================
# 9. Configuração Nativa do Niri (config.kdl)
# ==========================================
NIRI_CONF="$HOME/.config/niri/config.kdl"

if [ -f "$NIRI_CONF" ]; then
    # Substitui o valor da linha xcursor-theme mantendo a estrutura do arquivo
    sed -i -E "s/^([[:space:]]+)xcursor-theme \".*\"/\1xcursor-theme \"$NIRI_CURSOR\"/" "$NIRI_CONF"
fi

# ==========================================
# 9. Configuração Nativa do Niri (config.kdl)
# ==========================================
WAY_EDGES_CONF="$HOME/.config/way-edges/config.kdl"

if [ -f "$WAY_EDGES_CONF" ]; then
    # Substitui o valor da linha xcursor-theme mantendo a estrutura do arquivo
    sed -i -E "s/^([[:space:]]+)fg-color \".*\"/\1fg-color \"$WAY_EDGES_FG\"/" "$WAY_EDGES_CONF"
    sed -i -E "s/^([[:space:]]+)bg-text-color \".*\"/\1bg-text-color \"$WAY_EDGES_FG\"/" "$WAY_EDGES_CONF"
    sed -i -E "s/^([[:space:]]+)text-color \".*\"/\1text-color \"$WAY_EDGES_FG\"/" "$WAY_EDGES_CONF"
    sed -i -E "s/^([[:space:]]+)focus-color \".*\"/\1focus-color \"$WAY_EDGES_FG\"/" "$WAY_EDGES_CONF"

    sed -i -E "s/^([[:space:]]+)color \".*\"/\1color \"$WAY_EDGES_BG\"/" "$WAY_EDGES_CONF"
    sed -i -E "s/^([[:space:]]+)bg-color \".*\"/\1bg-color \"$WAY_EDGES_BG\"/" "$WAY_EDGES_CONF"
    sed -i -E "s/^([[:space:]]+)fg-text-color \".*\"/\1fg-text-color \"$WAY_EDGES_BG\"/" "$WAY_EDGES_CONF"
    sed -i -E "s/^([[:space:]]+)default-color \".*\"/\\1default-color \"$WAY_EDGES_BG\"/" "$WAY_EDGES_CONF"
fi
