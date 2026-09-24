function wiki
   if [ "$EDITOR" = "nvim" ];
      $EDITOR +VimwikiIndex +RainbowParentheses!
   end
end
