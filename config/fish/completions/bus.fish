set -l commands (bus --help \
                 | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\): \([[:alnum:] ]*\).*$/\1/p' \
                 | sed '/^$/d')

for c in $commands;
  set -l desc (bus --help \
               | grep -e "^[[:space:]]\+$c" \
               | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\): \([[:alnum:] ]*\).*$/\2/p' \
               | sed '/^$/d')
  complete -c bus -x -n "not __fish_seen_subcommand_from $commands" -a "$c" -d "$desc"
end
