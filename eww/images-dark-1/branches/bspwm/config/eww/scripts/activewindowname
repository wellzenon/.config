#!/bin/bash
name() {
  winame=`xdotool getactivewindow getwindowname`
  windowname=`echo ${winame::100}`
  if [[ $winame == "" ]]; then
    echo "Desktop"
  else
    echo "$windowname"
  fi
}
name
