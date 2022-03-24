# Custom functions
# Clear the screen
function clear
   printf "\033c"
end

# Checks if the current shell is a TMUX session
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

function reload_completions
   for file in (find $HOME/config/fish/completions/*.fish -print0 | string split0)
      source $file
   end
end

function refresh
   exec fish
   reload_completions
end

function configs
   set -l CONFIGS_GIT_DIR $HOME/.cfg

   git --git-dir="$CONFIGS_GIT_DIR" --work-tree="$HOME" $argv
end

# Autoload all declared functions
# New functions should be above this line for readability
set -l funcs (cat (status filename) | grep -Eo 'function [[:alnum:]_]+' | sed 's/function \(.*\)/\1/g')
for func in $funcs
   funcsave -q $func
end
