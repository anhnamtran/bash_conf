#!/bin/bash
TOUCHPAD_OFF=$(synclient -l | grep Touchpad | awk '{ print $3 }')

if (( TOUCHPAD_OFF == 0 )); then
  synclient Touchpadoff=1
else
  synclient Touchpadoff=0
fi
