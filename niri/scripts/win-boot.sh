#!/bin/bash

BOOTNUM=$(efibootmgr | awk '/[Ww]indows/ { gsub(/[^0-9]/,"",$1); print $1; exit }')
[ -n "$BOOTNUM" ] || { echo "Windows boot entry not found" >&2; exit 1; }

sudo /usr/sbin/efibootmgr -n "$BOOTNUM"
sudo /bin/systemctl reboot
