#!/usr/bin/env bash
if ! type speedtest-cli &>/dev/null; then
  exit 1
fi

SLEEP_PID=0
SLEEP_INT="$1"

run_speedtest() {
  if ! nc -zw1 google.com 443; then
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
  if [[ -z "$download" && -z "$upload" ]]; then
    echo ""
    return
  fi
  echo " $download" " $upload"
}

trap run_speedtest SIGUSR1

while true; do
  run_speedtest
  sleep "$SLEEP_INT" &
  SLEEP_PID=$!
  wait
done
