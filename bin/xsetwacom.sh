#!/usr/bin/env bash

# The device might not be ready by the time systemd invokes it
for _ in $(seq 10); do
  if xsetwacom list devices | grep -q Wacom; then
      break
  fi
  sleep 1
done

wacom() {
  xsetwacom "$@"
}

PRIMARY_MONITOR=$(xrandr --query \
                  | grep " connected" \
                  | grep " primary" \
                  | grep -o '[0-9]\{1,4\}x[0-9]\{1,4\}+[0-9]\{1,4\}+[0-9]\{1,4\}')
PAD=$(wacom list devices \
      | grep 'type: PAD' \
      | sed 's/[ \t]*id:.*$//')
STYLUS=$(wacom list devices \
         | grep 'type: STYLUS' \
         | sed 's/[ \t]*id:.*$//')

# Bind the pad to the primary monitor
wacom set "$PAD" MapToOutput "$PRIMARY_MONITOR"
wacom set "$STYLUS" MapToOutput "$PRIMARY_MONITOR"

# Remap the buttons
wacom set "$PAD" Button 1 "key +ctrl z -ctrl"
wacom set "$PAD" Button 2 "key +ctrl r -ctrl"
wacom set "$PAD" Button 3 "button 2"
wacom set "$PAD" Button 8 "button 3"

wacom set "$STYLUS" Button 2 "button 2"
wacom set "$STYLUS" Button 3 "button 3"
