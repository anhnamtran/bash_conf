#!/bin/bash
sudo perl -i -pne 's/reserved="true"/               /g' /usr/lib/firefox/browser/omni.ja
find ~/.cache/mozilla/firefox -type d -name startupCache -print0 | xargs -0 rm -rf
