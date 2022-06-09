#!/bin/bash
if ! pgrep -x spotify > /dev/null 2>&1; then
  kill -s SIGINT "$1"
  exit 1
fi

META_DATA=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata)

get_song_name() {
  echo "$META_DATA" | sed -n '/title/{n;p}' | awk '{ sep = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s }'
}

get_first_artist() {
  echo "$META_DATA" | sed -n '/artist/{n;n;p}' | awk '{ sep = ""; for (i = 2; i <= NF; i++) s = s $i " "; print s }'
}

printf "$(get_song_name)- $(get_first_artist)\n"
