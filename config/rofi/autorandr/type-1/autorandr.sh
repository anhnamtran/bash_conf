#!/usr/bin/env bash

## Author : Andrew Tran
## Github : @anhnamtran
#
## Rofi   : Autorandr Selector
#
## Available Styles
#
## style-1     style-2     style-3     style-4     style-5

dir="$HOME/.config/rofi/autorandr/type-1"
theme='style-1'

# Autorandr info
current_profile=$(autorandr --current)
current_profile="${current_profile:-$(autorandr --detected)}"

options=$(autorandr --list | sort)
options="${options} common clone-largest horizontal vertical"
yes=' Yes'
no=' No'

# Rofi CMD
rofi_cmd() {
	rofi -monitor -1 \
    -dmenu \
		-p "Autorandr" \
		-mesg "Current profile: $current_profile" \
		-theme ${dir}/${theme}.rasi
}

# Confirmation CMD
confirm_cmd() {
	rofi -monitor -1 \
    -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 300px;}' \
		-theme-str 'mainbox {children: [ "message", "listview" ];}' \
		-theme-str 'listview {columns: 2; lines: 1;}' \
		-theme-str 'element-text {horizontal-align: 0.5;}' \
		-theme-str 'textbox {horizontal-align: 0.5;}' \
		-dmenu \
		-p 'Confirmation' \
		-mesg 'Are you Sure?' \
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
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
    autorandr --load "$1"
	else
		exit 0
	fi
}

# Actions
chosen="$(run_rofi)"
if [[ -n "$chosen" ]] && [[ $options =~ $chosen ]]; then
  run_cmd "$chosen"
fi
