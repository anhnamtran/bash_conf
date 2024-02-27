# Complete for git -C shortcut gd
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
complete -x -c gd -a "(__gd_git_complete)"
