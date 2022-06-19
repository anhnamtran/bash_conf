#!/bin/bash
options="tree|scratch"

i3_tree() {
  HELP='Runs i3-msg -t get_tree'
  i3-msg -t get_tree
}

i3_scratch() {
  HELP='Gets the number of containers in the scratch pad'
  i3_tree | jq '.. |."scratchpad_state"? | select(. != null)' | rg -c fresh
}

i3_help() {
  HELP='Prints this help'
  fmt="%-5s%-12s%-25s\n"
  echo "Usage: i3-extra.sh {$options}"
  IFS='|'
  for opt in $options; do
    local def=$(type i3_$opt | grep -m 1 "HELP" | sed "s/HELP='\(.*\)'.*/\1/g")
    printf "$fmt" " " "$opt" "$def"
  done
}

cmd="$1"
shift 1
if [[ -n $cmd ]] && [[ $options =~ $cmd ]]; then
  i3_"$cmd" "$@"
else
  i3_help
fi
