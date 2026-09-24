# Completions for 'amake' command
set -l commands (amake complete \
                  | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\).*$/\1/p' \
                  | sed '/^$/d')
set -l packageCommands all check rpm product clean conf confall cdbgen go pylint
set -l packages (ls -1 /src/)

complete -c amake -f

complete -c amake -n "not __fish_seen_subcommand_from $commands" \
   -a "$commands"

complete -c amake -n "__fish_seen_subcommand_from $packageCommands" \
   -a "$packages"
