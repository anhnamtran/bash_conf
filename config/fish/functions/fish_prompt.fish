# Customized prompt
function fish_prompt
   set -l lastStatus $status
   set -l topPromptStart "╭╴"
   set -l bottomPromptStart "╰╴"
   set -l time (date +%H:%M:%S)
   set -l dir (prompt_pwd -d 0)
   set -l promptEnd ""
   set -l userAndHost "$USER"@(prompt_hostname)

   if functions -q fish_is_root_user; and fish_is_root_user
      set promptEnd "#"
   end

   # git prompt set up
   set -g __fish_git_prompt_show_informative_status 1

   set -g __fish_git_prompt_showstashstate 1

   set -g __fish_git_prompt_color_branch yellow
   set -g __fish_git_prompt_showupstream "informative"
   set -g __fish_git_prompt_char_upstream_ahead " "
   set -g __fish_git_prompt_char_upstream_behind " "
   set -g __fish_git_prompt_char_upstream_prefix ""

   set -g __fish_git_prompt_char_stateseparator " 〉"
   set -g __fish_git_prompt_char_stagedstate " "
   set -g __fish_git_prompt_char_dirtystate "󰐕"
   set -g __fish_git_prompt_char_untrackedfiles " "
   set -g __fish_git_prompt_char_conflictedstate ""
   set -g __fish_git_prompt_char_cleanstate " "
   set -g __fish_git_prompt_char_stashstate "󰆢 "

   set -g __fish_git_prompt_color_dirtystate blue
   set -g __fish_git_prompt_color_stagedstate green
   set -g __fish_git_prompt_color_invalidstate red
   set -g __fish_git_prompt_color_untrackedfiles red
   set -g __fish_git_prompt_color_cleanstate green --bold
   set -g __fish_git_prompt_color_stashstate green

   set -l modeIndicator
   switch $fish_bind_mode
      case default
         set modeIndicator (set_color green)'[N] '
      case insert
         set modeIndicator (set_color blue)'[I] '
      case replace_one
         set modeIndicator (set_color cyan)'[r] '
      case replace
         set modeIndicator (set_color cyan --bold)'[R] '
      case visual
         set modeIndicator (set_color green --bold)'[V] '
   end

   set -l statusColor (set_color --bold green)
   if [ $lastStatus -ne 0 ]
      set statusColor (set_color --bold red)
   end


   if [ -d $dir/.git ] || git rev-parse --git-dir >/dev/null 2>&1
      set gitPrompt (fish_git_prompt '%s')
      set gitDir (basename (git rev-parse --show-toplevel))
      set repoName (basename -s .git (git config --get remote.origin.url) 2>/dev/null || hostname)
      set gitStart "git@$repoName:"
      set dir (string match -r "$gitDir.*" "$dir")
   else
      set gitStart ""
      set gitPrompt ""
   end

   set -l kubePrompt (__kube_prompt)

   echo -es $topPromptStart $gitStart (set_color --bold blue) $dir (set_color normal) ' ' $gitPrompt
   echo -es $bottomPromptStart $modeIndicator $time (set_color --bold purple) ' ' $userAndHost ' ' $statusColor $promptEnd (set_color normal) ' '
end
