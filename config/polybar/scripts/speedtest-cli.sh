#!/usr/bin/env bash
if ! type speedtest-cli &>/dev/null; then
  exit 1
fi

SLEEP_PID=0
SLEEP_INT="$1"
SHOULD_SLEEP=1

TEST_PID=0
TEST_OUT="$HOME/.cache/polybar-scripts/speedtest-cli.json"

run_speedtest() {
  SHOULD_SLEEP=1
  if ! nc -zw1 google.com 443 &>/dev/null; then
    echo "No connection."
    exit 1
  fi

  echo "Running speedtest..."
  speedtest-cli --secure --timeout 5 --json 2> /dev/null > "$TEST_OUT" &
  TEST_PID=$!
  wait
  local download=$(cat "$TEST_OUT" | jq '.download' | numfmt --to iec --format '%.2fb/s')
  local upload=$(cat "$TEST_OUT" | jq '.upload' | numfmt --to iec --format '%.2fb/s')
  if [[ -z "$download" && -z "$upload" ]]; then
    echo ""
    return
  fi
  echo " $download" " $upload"
}

handle_signal() {
  if (( $SLEEP_PID != 0 )); then
    kill "$SLEEP_PID" &>/dev/null
  fi
  if (( $TEST_PID != 0 )); then
    kill "$TEST_PID" &>/dev/null
    SHOULD_SLEEP=0
  fi
}

trap handle_signal SIGUSR1

while true; do
  run_speedtest
  if (( SHOULD_SLEEP != 0 )); then
    sleep "$SLEEP_INT" &
    SLEEP_PID=$!
  fi
  wait
done
