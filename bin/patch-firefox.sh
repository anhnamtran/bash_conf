#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: sudo ./patch-firefox.sh <USER>"
  exit 1
fi
USER=$1
FF_PATH="/snap/firefox/2088/usr/lib/firefox/omni.ja"
if ! sudo grep 'reserved="true"' "$FF_PATH"; then
  echo "Firefox already patched"
else
  sudo perl -i -pne 's/reserved="true"/               /g' /usr/lib/firefox/browser/omni.ja
fi
echo "Clearing cache"
find /home/$USER/.cache/mozilla/firefox -type d -name startupCache -print0 | xargs -0 rm -rf
