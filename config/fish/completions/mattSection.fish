# Completion for mattSection
set -l commands (mattSection help \
                  | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\).*$/\1/p' \
                  | sed '/^$/d')

complete -c mattSection -f

complete -c mattSection -n "not __fish_seen_subcommand_from $commands" \
   -a "$commands"
