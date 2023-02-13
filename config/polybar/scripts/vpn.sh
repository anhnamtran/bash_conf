#!/usr/bin/env bash
# Provides VPN status and allows for menu based connection
VPN_BIN=nordvpn
if ! type $VPN_BIN &> /dev/null; then
  exit 1
fi

options="status|connect|disconnect"
vpn_status() {
  local status=$($VPN_BIN status)
  if echo "$status" | grep -q "Connected"; then
    local country=$(echo "$status" | grep "Country" | awk '{ print $2 }')
    local city=$(echo "$status" | grep "City" | awk '{ print $2 }')
    if [[ -n "$city" ]]; then
      echo "$country/$city"
    else
      echo "$country"
    fi
    exit 0
  else
    echo "Not connected"
    exit 1
  fi
}

vpn_disconnect() {
  $VPN_BIN disconnect
}

vpn_connect() {
  $HOME/config/rofi/vpn/type-1/vpn.sh
}

CMD=$1
if [[ $CMD =~ $options ]]; then
  vpn_$CMD "$@"
else
  exit 2
fi
