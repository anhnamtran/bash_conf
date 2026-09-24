function refreshCompletionCache
   if [ -d $HOME/.cache/completions ]
      rm -rf $HOME/.cache/completions/*
   end
end
