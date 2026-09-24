# Complete for git -C shortcut gd
function __gd_packages_from_prompt_cache
   set -l currentContainer "$(hostname -s)"
   set -l cacheDir "/tmp/fish/prompt"
   set -l cacheFile "$cacheDir/$currentContainer"
   if [ -f "$cacheFile" ]
      cat "$cacheFile"
   end
end
complete -x -c gd -n "not __fish_seen_subcommand_from (__gd_packages_from_prompt_cache)" -a "(__gd_packages_from_prompt_cache)"

function __gd_git_complete
   set -l tokens (commandline -poc)
   set -l current (commandline -ptc)
   set -l package "$tokens[2]"
   set -l space " "
   if string match -- '-*' "$current"
      complete -C "git -C $package $tokens[3..] $current"
   else
      complete -C "git -C $package $tokens[3..] "
   end
end
complete -x -c gd -n "__fish_seen_subcommand_from (__gd_packages_from_prompt_cache)" -a "(__gd_git_complete)"
