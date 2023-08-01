#!/usr/bin/env bash
# Script parameters are passed as environment variables for ease of use with
# built-in tray module
AUTO_HIDE_TRAY=${AUTO_HIDE_TRAY:-false}
START_TRAY_HIDDEN=${START_TRAY_HIDDEN:-false}

CACHE_DIR="$HOME/.cache/polybar-scripts"
mkdir -p "$CACHE_DIR"

# If the lock file exists, the tray is currently hidden
LOCK_FILE="tray_toggle.lock"

SLEEP_PID=0
SELF_PID=$$

VISIBILITY_TIMEOUT=5
AUTO_HIDE_PID=0

DEBUG=${DEBUG:-}
debug() {
  if [[ -z "$DEBUG" ]]; then
    return
  fi
  echo "DEBUG: $*"
}

auto_hide() {
  if [[ "$AUTO_HIDE_TRAY" = "false" ]]; then
    return
  fi
  debug "Waiting $VISIBILITY_TIMEOUT before hiding"
  sleep $VISIBILITY_TIMEOUT &
  AUTO_HIDE_PID=$!
  wait

  if [[ -f "$CACHE_DIR/$LOCK_FILE" ]]; then
    debug "Tray already hidden"
    return
  fi
  kill -USR1 $SELF_PID
}

show_tray() {
  debug "Showing tray"

  polybar-msg action tray module_show &>/dev/null
  echo ""

  rm -f "$CACHE_DIR/$LOCK_FILE"

  auto_hide
}

hide_tray() {
  debug "Hiding tray"

  polybar-msg action tray module_hide &>/dev/null
  echo "󰄽"

  touch "$CACHE_DIR/$LOCK_FILE"
}

handle_click() {
  if [ -f "$CACHE_DIR/$LOCK_FILE" ]; then
    show_tray
  else
    hide_tray
  fi
}

handle_start() {
  if [ "$START_TRAY_HIDDEN" = "true" ]; then
    hide_tray
  else
    show_tray
  fi
}

handle_sig() {
  if (( $SLEEP_PID != 0 )); then
    kill $SLEEP_PID &>/dev/null
  fi
  if (( $AUTO_HIDE_PID != 0 )); then
    kill $AUTO_HIDE_PID &>/dev/null
  fi
  handle_click
}

trap "handle_sig" SIGUSR1

handle_start
while true; do
  sleep infinity &
  SLEEP_PID=$!
  wait
done
