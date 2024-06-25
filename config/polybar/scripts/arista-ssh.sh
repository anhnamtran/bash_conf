#!/usr/bin/bash

assh() {
  if ! type arista-ssh &>/dev/null; then
    exit 1
  fi
  arista-ssh "$@"
}

assh_check_auth() {
  assh check-auth | grep -q "valid" && echo "󰕥 " || echo "󰫜 "
}

assh_login() {
  echo "󰂪 "
  assh login &>/dev/null
}

trap assh_login SIGUSR1
while true; do
  assh_check_auth
  sleep 5
done
