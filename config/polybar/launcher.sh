#!/bin/bash
set -x

killall -w -e polybar

PRIMARY_MONITOR=$(xrandr --query | grep " connected" | grep " primary" | cut -d " " -f 1)
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
    if [ "$m" = "$PRIMARY_MONITOR" ]; then
      TRAY_POS='right'
    fi
    TRAY_POS=${TRAY_POS:-none} MONITOR=$m polybar --reload mainbar &
    unset TRAY_POS
  done
else
  polybar --reload mainbar &
fi
