function reload_completions
   for file in (find $HOME/config/fish/completions/*.fish -print0 | string split0)
      source $file
   end
end
