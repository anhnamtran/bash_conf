#!/usr/bin/env bash
DEVICE=$(upower -e | grep "mouse_hidpp_battery")
UPOWER_OUT=$(upower -i "$DEVICE")

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
