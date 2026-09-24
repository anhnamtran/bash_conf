# Defined in /home/andrew_nt/.config/fish/conf.d/functions.fish @ line 62
function __reload_completions
   for file in (find $HOME/config/fish/completions/*.fish -print0 | string split0)
      source $file
   end
end
