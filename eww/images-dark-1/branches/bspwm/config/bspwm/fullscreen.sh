#!/bin/bash

bspc subscribe node_state | while read -r _ _ _ _ state flag; do
  if [ "$state" != "fullscreen" ]; then
    continue
  fi

  if [ "$flag" == on ]; then
    eww close-all
    killall picom
  else
    xrandr --output eDP1 --auto
    picom &
    eww open bar
  fi
done &
