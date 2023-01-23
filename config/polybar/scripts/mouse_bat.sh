#!/usr/bin/env bash
UPOWER_OUT=$(upower -i /org/freedesktop/UPower/devices/mouse_hidpp_battery_5)

STATE=$(echo "$UPOWER_OUT" | sed -n -e 's/state: \+\(.*\)/\1/p' | xargs)
PERCENTAGE=$(echo "$UPOWER_OUT" | sed -n -e 's/percentage: \+\(.*%\).*/\1/p' | xargs)

if (( $# > 1 )); then
  echo "Usage: mouse_bat.sh state|percentage"
  exit 1
fi

case "$1" in
  state)
    echo "$STATE"
    ;;
  percentage)
    echo "$PERCENTAGE"
    ;;
  *)
    echo "Usage: mouse_bat.sh state|percentage"
    exit 1
    ;;
esac
