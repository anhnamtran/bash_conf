#!/bin/bash

AUTORANDR_PROFILES=$(autorandr --list | sort)
AUTORANDR_PROFILES="$AUTORANDR_PROFILES common clone-largest horizontal vertical"
if (( ROFI_RETV == 0 )); then
  echo -en "\0prompt\x1fautorandr\n"
  for prof in $AUTORANDR_PROFILES; do
    echo "$prof"
  done
else
  if [[ $AUTORANDR_PROFILES =~ $1 ]]; then
    autorandr --load $1 2>&1 > /dev/null
  else
    exit 1
  fi
fi
