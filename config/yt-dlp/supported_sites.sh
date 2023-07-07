#!/usr/bin/env bash
FILE_URL='https://raw.githubusercontent.com/yt-dlp/yt-dlp/master/supportedsites.md'

if (( $# == 0)); then
  curl -sL "$FILE_URL"
  exit 0
fi

if (( $# != 1 )); then
  echo "Usage: ./supported_sites.sh [site-regex]"
  exit 1
fi

curl -sL "$FILE_URL" | grep -i "$1"
