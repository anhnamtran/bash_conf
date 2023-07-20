#!/usr/bin/bash
# Outputs the current window title and a count of windows currently in the
# scratchpad
SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

# Maximum length for the window title
MAX_LEN=${1:-15}

wintitle() {
  local title=$(xdotool getactivewindow getwindowname 2>/dev/null)
  if [[ "${#title}" -gt "$MAX_LEN" ]]; then
    echo "${title:0:$MAX_LEN}..."
  else
    echo "$title"
  fi
}
scratchpad() {
  "$SCRIPT_DIR"/i3-extra.sh scratch
}

while true; do
  WIN_TITLE="$(wintitle)"
  SCRATCH_PAD_NUM="$(scratchpad)"
  if [[ -n "$SCRATCH_PAD_NUM" ]]; then
    OUTPUT="$WIN_TITLE   $SCRATCH_PAD_NUM"
  else
    OUTPUT="$WIN_TITLE"
  fi
  echo "$OUTPUT"
  sleep 1
done
