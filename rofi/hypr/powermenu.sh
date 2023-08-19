#!/bin/bash

lock=" Lock"
logout=" Logout"
shutdown="襤 Poweroff"
reboot=" Reboot"
sleep=" Suspend"

selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu -i -p "Powermenu" \
	-theme "~/.config/rofi/hypr/powermenu.rasi")

if [ "$selected_option" == "$lock" ]; then
	swaylock
elif [ "$selected_option" == "$logout" ]; then
	loginctl terminate-user $(whoami)
elif [ "$selected_option" == "$shutdown" ]; then
	loginctl poweroff
elif [ "$selected_option" == "$reboot" ]; then
	loginctl reboot
elif [ "$selected_option" == "$sleep" ]; then
	loginctl suspend
else
	echo "No match"
fi
