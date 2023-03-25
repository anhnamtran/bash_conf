#!/usr/bin/env bash
if ! type speedtest-cli &>/dev/null; then
  exit 1
fi

SLEEP_PID=0
SLEEP_INT="$1"

run_speedtest() {
  if ! ping -W 5 -c 1 google.com &>/dev/null; then
    echo "No connection."
    exit 1
  fi

  if (( $SLEEP_PID != 0 )); then
    kill $SLEEP_PID &>/dev/null
  fi

  echo "Running speedtest..."
  local speed_test_json=$(speedtest-cli --timeout 5 --json 2> /dev/null)
  local download=$(echo "$speed_test_json" | jq '.download' | numfmt --to iec --format '%.2fb/s')
  local upload=$(echo "$speed_test_json" | jq '.upload' | numfmt --to iec --format '%.2fb/s')
  echo "$download" "$upload"
}

trap run_speedtest SIGUSR1

while true; do
  run_speedtest
  sleep "$SLEEP_INT" &
  SLEEP_PID=$!
  wait
done
