#!/bin/bash

workspaces() {
  x=`xdotool get_desktop`
  a=x+1

  o1=`bspc query -D -d .occupied --names | grep 1`
  o2=`bspc query -D -d .occupied --names | grep 2`
  o3=`bspc query -D -d .occupied --names | grep 3`
  o4=`bspc query -D -d .occupied --names | grep 4`
  o5=`bspc query -D -d .occupied --names | grep 5`

  if [[ $a -eq 1 ]]; then
    w1=bar-active-ws
    if [[ $o2 -eq 2 ]]; then
      w2=bar-occupied-ws
      if [[ $o3 -eq 3 ]]; then
        w3=bar-occupied-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w3=bar-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    else
      w2=bar-ws
      if [[ $o3 -eq 3 ]]; then
        w3=bar-occupied-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w3=bar-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    fi
  elif [[ $a -eq 2 ]]; then
    w2=bar-active-ws
    if [[ $o1 -eq 1 ]]; then
      w1=bar-occupied-ws
      if [[ $o3 -eq 3 ]]; then
        w3=bar-occupied-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w3=bar-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    else
      w1=bar-ws
      if [[ $o3 -eq 3 ]]; then
        w3=bar-occupied-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w3=bar-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    fi
  elif [[ $a -eq 3 ]]; then
    w3=bar-active-ws
    if [[ $o1 -eq 1 ]]; then
      w1=bar-occupied-ws
      if [[ $o2 -eq 2 ]]; then
        w2=bar-occupied-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w2=bar-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    else
      w1=bar-ws
      if [[ $o2 -eq 2 ]]; then
        w2=bar-occupied-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w2=bar-ws
        if [[ $o4 -eq 4 ]]; then
          w4=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w4=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    fi
  elif [[ $a -eq 4 ]]; then
    w4=bar-active-ws
    if [[ $o1 -eq 1 ]]; then
      w1=bar-occupied-ws
      if [[ $o2 -eq 2 ]]; then
        w2=bar-occupied-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w2=bar-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    else
      w1=bar-ws
      if [[ $o2 -eq 2 ]]; then
        w2=bar-occupied-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      else
        w2=bar-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o5 -eq 5 ]]; then
            w5=bar-occupied-ws
          else
            w5=bar-ws
          fi
        fi
      fi
    fi
  elif [[ $a -eq 5 ]]; then
    w5=bar-active-ws
    if [[ $o1 -eq 1 ]]; then
      w1=bar-occupied-ws
      if [[ $o2 -eq 2 ]]; then
        w2=bar-occupied-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        fi
      else
        w2=bar-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        fi
      fi
    else
      w1=bar-ws
      if [[ $o2 -eq 2 ]]; then
        w2=bar-occupied-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        fi
      else
        w2=bar-ws
        if [[ $o3 -eq 3 ]]; then
          w3=bar-occupied-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        else
          w3=bar-ws
          if [[ $o4 -eq 4 ]]; then
            w4=bar-occupied-ws
          else
            w4=bar-ws
          fi
        fi
      fi
    fi
  fi

  echo "(box :class \"bar-workspace\" :orientation \"h\" :spacing 10 :space-evenly false :halign \"start\" :hexpand false (label :class \"$w1\" :text \"一\") (label :class \"$w2\" :text \"二\") (label :class \"$w3\" :text \"三\") (label :class \"$w4\" :text \"四\") (label :class \"$w5\" :text \"五\"))"
}

workspaces
bspc subscribe all | while read -r _ ; do
  workspaces
done
