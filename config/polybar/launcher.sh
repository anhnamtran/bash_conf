#!/bin/bash
set -x

for pid in $(pgrep -x polybar); do
  kill -9 $pid
  sleep 1;
done

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
