#!/bin/bash
if [[ "$#" -ne 1 ]]; then
  echo "Usage: powersave.sh true|false"
  exit 1
fi

BACKLIGHT_BIN=${BACKLIGHT_BIN:-/usr/bin/light}
if ! [[ -e "$BACKLIGHT_BIN" ]]; then
  echo "Unable to find '$BACKLIGHT_BIN'"
  exit 1
fi

shopt -s nocasematch
case "$1" in
  true)
    $BACKLIGHT_BIN -S 0 -s sysfs/leds/tpacpi::kbd_backlight
    $BACKLIGHT_BIN -S 50 -s sysfs/backlight/intel_backlight
    ;;
  false | *)
    $BACKLIGHT_BIN -S 100 -s sysfs/leds/tpacpi::kbd_backlight
    $BACKLIGHT_BIN -S 100 -s sysfs/backlight/intel_backlight
esac
