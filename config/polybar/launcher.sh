#!/bin/bash
set -x

(

flock 200

killall -s 9 -w -e polybar

PRIMARY_MONITOR=$(xrandr --query | grep " connected" | grep " primary" | cut -d " " -f 1)
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
    if [ "$m" = "$PRIMARY_MONITOR" ]; then
      TRAY_POS='right'
      BAR=mainbar
    else
      TRAY_POS='none'
      BAR=secondarybar
    fi
     TRAY_POS=$TRAY_POS MONITOR=$m polybar --reload $BAR < /dev/null > /tmp/polybar.$m.log 2>&1 200>&- & disown
    unset TRAY_POS
  done
else
  polybar --reload mainbar &
fi

) 200>/tmp/polybar-launcher.lock
