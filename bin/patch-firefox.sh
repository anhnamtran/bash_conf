#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: ./patch-firefox.sh <USER>"
  exit 1
fi
USER=$1

set -e

PATCH_FILE="/home/$USER/bin/firefox-omni.patch"
PATCH_DIR="/tmp/firefox-omni"
PATCHED_OMNI="/tmp/omni.ja"

OMNI_PATH="/usr/lib/firefox/browser/omni.ja"

if [[ -d "$PATCH_DIR" ]]; then
  rm -rf "$PATCH_DIR"
fi
mkdir -p "$PATCH_DIR"

pushd "$PATCH_DIR"
unzip -q "$OMNI_PATH" || true

patch "$PATCH_DIR/chrome/browser/content/browser/browser.xhtml" "$PATCH_FILE"
zip -0DXqr "$PATCHED_OMNI" *
popd

sudo cp -v "$OMNI_PATH" "$OMNI_PATH.orig"
sudo cp -v "$PATCHED_OMNI" "$OMNI_PATH"

rm -rf "$PATCHED_OMNI" "$PATCH_DIR"

echo "Clearing cache"
find /home/$USER/.cache/mozilla/firefox -type d -name startupCache -print0 | xargs -0 rm -rf
