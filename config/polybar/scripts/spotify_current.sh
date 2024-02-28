#!/bin/bash
if ! pgrep -x spotify > /dev/null 2>&1; then
  kill -s SIGINT "$1"
  exit 1
fi

META_DATA=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:org.mpris.MediaPlayer2.Player string:Metadata)

get_song_name() {
  echo "$META_DATA" | sed -n '/title/{n;p}' | awk '{ sep = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s }' | sed -e 's/"//g' | awk '$1=$1'
}

get_first_artist() {
  echo "$META_DATA" | sed -n '/artist/{n;n;p}' | awk '{ sep = ""; for (i = 2; i <= NF; i++) s = s $i " "; print s }' | sed -e 's/"//g' | awk '$1=$1'
}

get_album() {
  echo "$META_DATA" | sed -n '/album\>/{n;p}' | awk '{ sep = ""; for (i = 3; i <= NF; i++) s = s $i " "; print s }' | sed -e 's/"//g' | awk '$1=$1'
}

TITLE="$(get_song_name)"
ARTIST="$(get_first_artist)"
ALBUM="$(get_album)"
if [[ -n "${ARTIST}" ]]; then
  BY="$ARTIST"
else
  BY="$ALBUM"
fi

printf '"%s" - "%s"\n' "$TITLE" "$BY"
