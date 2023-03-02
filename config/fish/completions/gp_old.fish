set -l commands (gp_old help \
                  | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\).*$/\1/p' \
                  | sed '/^$/d')

complete -c gp_old -x -n "not __fish_seen_subcommand_from $commands" -a "$commands"
