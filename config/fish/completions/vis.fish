function sessions
   find $HOME/.cache/nvim/sessions/ -name '*.vim'
end

complete -c vis -x
for session in (sessions)
   set -l name (basename $session)
   complete -c vis -n "not __fish_seen_subcommand_from (sessions)" -a "$session" -d "$name"
end
