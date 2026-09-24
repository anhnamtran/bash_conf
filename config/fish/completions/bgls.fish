# Completions for 'bgls' commands
set -l commands (bgls help \
                  | sed -ne 's/^[[:space:]]\+\([-]*[[:alnum:]_-]*\).*$/\1/p' \
                  | sed '/^$/d')

complete -c bgls -f

set -l jobHelpCmds hits

function __bglsCurrCmdHelp
  set -l currBglsCmd (commandline -pc)
  if [ -z "$currBglsCmd" ]
    echo ""
    return
  end
  if string match -q '*hits*' "$currBglsCmd"
      set helpText (a job ls --help)
  else
      set helpText (a bug ls --help)
  end
  echo $helpText | grep -Eo '\-\-[[:alnum:]-]+'
end

complete -c bgls -n "not __fish_seen_subcommand_from $commands" \
   -a "$commands"

set -l bugNums (a bg ls -u $USER | awk '{print $1}' | head -n -1)
set -l showCommands cal blocks graph id ed
set -l a4Users (a4 users | awk '{print $1}' | sort)
complete -c bgls -n "__fish_seen_subcommand_from $showCommands" \
   -a "$bugNums (__bglsCurrCmdHelp)"

complete -c bgls -n "__fish_seen_subcommand_from cr" \
   -a "(__bglsCurrCmdHelp)"

complete -c bgls -n "__fish_seen_subcommand_from $commands" \
   -s u -l user -x -a "$a4Users"
complete -c bgls -n "__fish_seen_subcommand_from $commands" \
   -s S -l status -x -a "a c/dup c/f c/wf c/wfm r/dup r/f r/wf r/wfm ro"
complete -c bgls -n "__fish_seen_subcommand_from $commands" \
   -s p -l package -x -a "(ls -1 /src/)"
complete -c bgls -n "__fish_seen_subcommand_from $commands" \
   -s i -l priority -x -a "df1 df2 df3 jail mu tvl tw"
complete -c bgls -n "__fish_seen_subcommand_from $commands" \
   -s y -l severity -x -a "lim n sev1 sev2 sev3 u"
