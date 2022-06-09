#!/bin/bash
_trap_zscroll() {
  killall zscroll > /dev/null 2>&1
}
trap _trap_zscroll SIGINT

SPOTIFY_CURRENT_SCRIPT="$HOME/.config/polybar/scripts/spotify_current.sh"

if ! type zscroll > /dev/null 2>&1; then
  "$SPOTIFY_CURRENT_SCRIPT" "$$"
  exit $?
fi

zscroll -l 20 \
  --delay 0.1 \
  --scroll-padding " " \
  --update-check true \
  "$SPOTIFY_CURRENT_SCRIPT $$" &

wait
