#!/usr/bin/env bash
/usr/bin/aria2c --conf-path=/home/andrew_nt/config/aria2/makepkg-aria2.conf "$1" -o "$2"
echo
