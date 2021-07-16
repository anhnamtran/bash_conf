function configs
   set -l CONFIGS_GIT_DIR $HOME/.cfg

   git --git-dir="$CONFIGS_GIT_DIR" --work-tree="$HOME" $argv
end
