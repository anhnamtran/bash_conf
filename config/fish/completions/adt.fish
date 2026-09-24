# Completions for 'adt' commands
set -l commands (adt help \
                  | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\).*$/\1/p' \
                  | sed '/^$/d')

set -l artHelp (a dut --help | grep '^ [a-zA-Z0-9]\+' | awk '{print $1}')

complete -c adt -f

complete -c adt -n "not __fish_seen_subcommand_from $commands $artHelp" \
   -a "$commands $artHelp"

function __artHelpCommand
  set -l currArtCommand (commandline -poc)
  if [ -z "$currArtCommand" ]
    echo ""
    return
  end
  a dut $currArtCommand[2] --help | grep -Eo -- '--[[:alnum:]-]+'
end

complete -c adt -n "__fish_seen_subcommand_from $artHelp" \
   -a "(__artHelpCommand)"
