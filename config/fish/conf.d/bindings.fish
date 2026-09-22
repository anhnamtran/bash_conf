# Change to Vi mode
function fish_user_key_bindings
   fish_vi_key_bindings insert
   # disabled for "jj-vcs" usage
   # bind -M insert -m default jj 'backward-char' 'repaint-mode'
   bind -M insert qq 'exit'
   bind -M default k 'up-or-search'
   bind -M default j 'down-or-search'
   bind -M insert \c] 'accept-autosuggestion'
   bind -M insert \ce 'edit_command_buffer'
   bind -M insert \eh 'fish_commandline_append " --help &| bat -l help"'
   bind -M insert enter repaint execute

   fzf_key_bindings
end

