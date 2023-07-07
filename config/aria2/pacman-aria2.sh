#!/usr/bin/env bash
echo "Downloading $1..."
/usr/bin/aria2c --conf-path=/home/andrew_nt/config/aria2/pacman-aria2.conf "$1"
