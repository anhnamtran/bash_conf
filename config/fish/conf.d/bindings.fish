# Change to Vi mode
function fish_user_key_bindings
   fish_vi_key_bindings --no-erase insert
   bind -M insert -m default jj 'backward-char' 'repaint-mode'
   bind -M insert qq 'exit'
   bind -M default k 'history-search-backward'
   bind -M default j 'history-search-forward'
   bind -M insert \cC 'commandline -r ""'
   bind -M insert \c] 'accept-autosuggestion'
end

