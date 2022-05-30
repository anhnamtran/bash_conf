set -l commands (gp help \
                  | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\).*$/\1/p' \
                  | sed '/^$/d')

complete -c gp -x -n "not __fish_seen_subcommand_from $commands" -a "$commands"
