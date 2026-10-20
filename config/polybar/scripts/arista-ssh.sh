#!/usr/bin/bash

sleep_pid=0

assh() {
  if ! type arista-ssh &>/dev/null; then
    exit 1
  fi
  if [ "$1" = "login" ]; then
    timeout -k 30 30 arista-ssh "$@"
  else
    arista-ssh "$@"
  fi
}

assh_check_auth() {
  assh check-auth 2>/dev/null | grep -q "valid" && echo "󰕥 " || echo "󰫜 "
}

assh_login() {
  notify-send -a "polybar" "Arista SSH" "Logging in..."
  echo "󰂪 "

  assh login &>/dev/null

  if [ "$sleep_pid" -ne 0 ]; then
    kill $sleep_pid >/dev/null 2>&1
  fi
}

trap assh_login SIGUSR1
while true; do
  assh_check_auth
  sleep 5 &
  sleep_pid=$!
  wait
done
