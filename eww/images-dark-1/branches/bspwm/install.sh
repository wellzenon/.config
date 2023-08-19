#!/bin/bash

cd ~/dotfiles
mv config/wezterm.lua ~/.wezterm.lua

# Installing yay
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Installing other packages
cd ~
yay -S linux-headers wezterm zsh neovim firefox-developer-edition lightdm lightdm-webkit2-greeter lightdm-webkit-theme-litarvan lightdm-webkit2-theme-glorious udisks2 unrar unzip ttf-jetbrains-mono-nerd ttf-iosevka-nerd ttf-iosevkaterm-nerd sof-firmware rofi rofi-emoji scrot dunst picom-simpleanims-next-git polkit-gnome ranger reflector-simple playerctl pavucontrol pamixer p7zip noto-fonts noto-fonts-cjk noto-fonts-emoji-apple neofetch mpv lxappearance-gtk3 iw htop gimp feh dragon-drop deluge-gtk webcord ccache brillo alsa-firmware alsa-ucm-conf bluez capitaine-cursors wmctrl zip upower ttf-roboto filezilla xdotool xorg-xprop xorg-xsetroot xdg-desktop-portal-gtk papirus-icon-theme betterlockscreen xorg-xclipboard xclip wireless_tools

# Installing mantis gtk theme
cd ~
mkdir ~/.themes
git clone https://github.com/mantissa-/mantis-theme.git
cd mantis-theme
mv Manti* ~/.themes
cd ~
rm -rf mantis-theme

# Setup dotfiles
mkdir ~/.config
cd ~/dotfiles/config
mv * ~/.config/

# Enabling execution permissions
cd ~
chmod +x dotfiles/wine.sh
chmod +x dotfiles/eww.sh
chmod +x dotfiles/post-install.sh
cd ~/.config
chmod +x bspwm/bspwmrc
chmod +x bspwm/fullscreen.sh
chmod +x bspwm/scrot.sh
chmod +x sxhkd/sxhkdrc
chmod +x dunst/dunstrc
chmod +x ranger/scope.sh
chmod +x scripts/ffmpeg.sh
chmod +x scripts/scrot.sh
chmod +x wmstuff/minimizer.sh
chmod +x eww/scripts/activewindowname
chmod +x eww/scripts/bluetooth
chmod +x eww/scripts/battery
chmod +x eww/scripts/brightness
chmod +x eww/scripts/cpu
chmod +x eww/scripts/kitty
chmod +x eww/scripts/memory
chmod +x eww/scripts/vertical-battery
chmod +x eww/scripts/vertical-workspaces
chmod +x eww/bar/scripts/volume
chmod +x eww/bar/scripts/wifi
chmod +x eww/bar/scripts/workspaces

# Installing eww and rust using rustup
cd ~
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
rustup install nightly
cd ~

# Setup ohmyzsh
cd ~
cd ~
echo "Last step is setting up ohmyzsh"
sleep 3
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
