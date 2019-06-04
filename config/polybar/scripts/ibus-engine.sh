#!/bin/bash
# Echos the current ibus engine in use.

ENGINE=$(ibus engine)
ENGINE=${ENGINE##*:*:}

shopt -s nocasematch

# By default, the script prints the tail of the engine name. To specially format
# an engine, add another case to the case statement
case "$ENGINE" in
  *en*)
    echo "EN"
    ;;
  *pinyin*)
    echo "ZH"
    ;;
  *unikey*)
    echo "VN"
    ;;
  *)
    echo "$ENGINE"
esac
