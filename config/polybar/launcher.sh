#!/bin/bash

pkill polybar

while pgrep -a polybar &> /dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
    MONITOR=$m polybar --reload mainbar &
  done
else
  polybar --reload mainbar &
fi
