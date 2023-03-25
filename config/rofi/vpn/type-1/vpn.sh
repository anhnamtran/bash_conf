#!/usr/bin/env bash

## Author : Andrew Tran
## Github : @anhnamtran
#
## Rofi   : Autorandr Selector
#
## Available Styles
#
## style-1

dir="$HOME/.config/rofi/vpn/type-1"
theme='style-1'

VPN_DEST=vpn_destinations.txt
VPN_BIN=nordvpn
if ! type $VPN_BIN &> /dev/null; then
  exit 1
fi

options=$(cat "$dir/$VPN_DEST")

# Rofi CMD
rofi_cmd() {
	rofi -monitor -1 \
    -dmenu \
		-p "VPN" \
		-mesg "Select a VPN destination" \
    -i -matching fuzzy \
		-theme ${dir}/${theme}.rasi
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
	echo "$options" | tr " " "\n" | rofi_cmd
}

# Execute Command
run_cmd() {
  local country=$(echo "$1" | cut -f1 -d'/')
  local city=$(echo "$1" | cut -f2 -d'/')

  $VPN_BIN connect "$country" "$city"
}

# Actions
chosen="$(run_rofi)"
if [[ -n "$chosen" ]] && [[ $options =~ $chosen ]]; then
  run_cmd "$chosen"
fi
