#!/bin/bash
TOUCHPAD_OFF=$(synclient -l | grep Touchpad | awk '{ print $3 }')

if [[ "$1" == "status" ]]; then
  echo "$TOUCHPAD_OFF"
  exit "$TOUCHPAD_OFF"
fi

if (( TOUCHPAD_OFF == 0 )); then
  synclient Touchpadoff=1
else
  synclient Touchpadoff=0
fi
