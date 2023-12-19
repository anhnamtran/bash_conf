#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Generic DMENU for other programs to use
#
## Available Styles
#
## style-1

dir="$HOME/.config/rofi/dmenu/type-1"
theme='style-1'

## Run
rofi -monitor -1 \
    -dmenu \
    -i -matching fuzzy \
    -theme ${dir}/${theme}.rasi \
    "$@"
