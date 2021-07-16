function check_tmux
  if [ -z "$TMUX" ]
     if [ -n "$WP" ]
        if ! type tmux > /dev/null 2>&1
           echo (set_color red --bold)"No TMUX installed."(set_color normal)
        end
     else
         echo (set_color red --bold)"No TMUX installed."(set_color normal)
     end
  end
end
