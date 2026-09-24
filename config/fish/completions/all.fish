# Completion for a-all
set -l commands (all help \
                  | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\).*$/\1/p' \
                  | sed '/^$/d')

complete -c all -f

complete -c all -n "not __fish_seen_subcommand_from $commands" \
   -a "$commands"
