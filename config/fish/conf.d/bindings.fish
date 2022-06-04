# Change to Vi mode
function fish_user_key_bindings
   fish_vi_key_bindings insert
   bind -M insert -m default jj 'backward-char' 'repaint-mode'
   bind -M insert qq 'exit'
   bind -M default k 'up-or-search'
   bind -M default j 'down-or-search'
   bind -M insert \c] 'accept-autosuggestion'
   bind -M insert \ce 'edit_command_buffer'
end

