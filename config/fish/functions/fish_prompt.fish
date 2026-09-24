function __fish_git_prompt_ready --description "Returns false on slower file systems"
  # Check filesystem type
  set -l mount_type (df -T . 2>/dev/null | tail -1 | awk '{print $2}')
  if not contains -- $mount_type fuse.sshfs sshfs nfs cifs smb fuse.rclone
    return 0
  end
  return 1
end

# Customized prompt

# Fish 4.9.3 uses `git describe` to name a detached HEAD. In colocated
# Jujutsu repositories that scans every refs/jj/keep ref before falling back
# to the commit ID. Keep Fish's status handling, but make that fallback
# immediate.
functions -q fish_git_prompt
function __fish_git_prompt_operation_branch_bare
   set -l git_dir $argv[1]
   set -l inside_gitdir $argv[3]
   set -l bare_repo $argv[4]
   set -q argv[6]
   and set -l sha $argv[6]

   set -l branch
   set -l operation
   set -l detached no
   set -l bare
   set -l step
   set -l total

   if test -d $git_dir/rebase-merge
      set branch (command cat $git_dir/rebase-merge/head-name 2>/dev/null)
      set step (command cat $git_dir/rebase-merge/msgnum 2>/dev/null)
      set total (command cat $git_dir/rebase-merge/end 2>/dev/null)
      if test -f $git_dir/rebase-merge/interactive
         set operation "|REBASE-i"
      else
         set operation "|REBASE-m"
      end
   else
      if test -d $git_dir/rebase-apply
         set step (command cat $git_dir/rebase-apply/next 2>/dev/null)
         set total (command cat $git_dir/rebase-apply/last 2>/dev/null)
         if test -f $git_dir/rebase-apply/rebasing
            set branch (command cat $git_dir/rebase-apply/head-name 2>/dev/null)
            set operation "|REBASE"
         else if test -f $git_dir/rebase-apply/applying
            set operation "|AM"
         else
            set operation "|AM/REBASE"
         end
      else if test -f $git_dir/MERGE_HEAD
         set operation "|MERGING"
      else if test -f $git_dir/CHERRY_PICK_HEAD
         set operation "|CHERRY-PICKING"
      else if test -f $git_dir/REVERT_HEAD
         set operation "|REVERTING"
      else if test -f $git_dir/BISECT_LOG
         set operation "|BISECTING"
      end
   end

   if test -n "$step" -a -n "$total"
      set operation "$operation $step/$total"
   end

   if test -z "$branch"
      if not set branch (command git symbolic-ref HEAD 2>/dev/null)
         set detached yes
         if set -q sha
            set branch (string shorten -m8 -c "" -- $sha)
         else
            set branch unknown
         end
         set branch "($branch)"
      end
   end

   if test true = $inside_gitdir
      if test true = $bare_repo
         set bare "BARE:"
      else
         set branch "GIT_DIR!"
      end
   end

   echo $operation
   echo $branch
   echo $detached
   echo $bare
end

function fish_prompt
   set -l lastStatus $status
   set -l topPromptStart (set_color --dim) "╭╴"
   set -l bottomPromptStart (set_color --dim) "╰╴"
   set -l time (date +%H:%M:%S)
   set -l dir (prompt_pwd -d 0)
   set -l promptEnd "󰫍 "
   set -l userAndHost (set_color --dim green) "$USER" (set_color normal) @ (set_color --dim purple) (prompt_hostname) (set_color normal)

   if functions -q fish_is_root_user; and fish_is_root_user
      set promptEnd "#"
   end

   # git prompt set up
   set -gx __fish_git_prompt_show_informative_status 1

   set -gx __fish_git_prompt_showdirtystate 1
   set -gx __fish_git_prompt_showstashstate 1
   set -gx __fish_git_prompt_showuntrackedfiles 1

   set -gx __fish_git_prompt_color_branch yellow
   set -gx __fish_git_prompt_showupstream "informative"
   set -gx __fish_git_prompt_char_upstream_ahead " "
   set -gx __fish_git_prompt_char_upstream_behind " "
   set -gx __fish_git_prompt_char_upstream_diverged "󱀝"

   set -gx __fish_git_prompt_char_stateseparator " "
   set -gx __fish_git_prompt_char_stagedstate " "
   set -gx __fish_git_prompt_char_dirtystate "󰐕"
   set -gx __fish_git_prompt_char_untrackedfiles " "
   set -gx __fish_git_prompt_char_invalidstate " "
   set -gx __fish_git_prompt_char_cleanstate " "
   set -gx __fish_git_prompt_char_stashstate "󰆢 "

   set -gx __fish_git_prompt_color_dirtystate blue
   set -gx __fish_git_prompt_color_stagedstate green
   set -gx __fish_git_prompt_color_invalidstate red
   set -gx __fish_git_prompt_color_untrackedfiles red
   set -gx __fish_git_prompt_color_cleanstate green
   set -gx __fish_git_prompt_color_stashstate green

   set -l modeIndicator
   switch $fish_bind_mode
      case default
         set modeIndicator (set_color --dim green) '[' (set_color --bold green) 'n' (set_color normal) (set_color --dim green) '] '
      case insert
         set modeIndicator (set_color --dim blue) '[' (set_color blue --bold) 'i' (set_color normal) (set_color --dim blue) '] '
      case replace_one
         set modeIndicator (set_color --dim cyan) '[' (set_color cyan --bold) 'r' (set_color normal) (set_color --dim cyan) '] '
      case replace
         set modeIndicator (set_color --dim cyan) '[' (set_color cyan --bold) 'R' (set_color normal) (set_color --dim cyan) '] '
      case visual
         set modeIndicator (set_color --dim green) '[' (set_color green --bold) 'v' (set_color normal) (set_color --dim green) '] '
   end

   set -l statusColor (set_color --bold green)
   if [ $lastStatus -ne 0 ]
      set statusColor (set_color --bold red)
   end

   # Prefer JJ for JJ-only repositories and for colocated repositories with
   # detached Git HEADs. Keep Git for colocated repositories on a branch.
   set -l gitRoot (command git rev-parse --show-toplevel 2>/dev/null)
   set -l jjRoot
   set -l gitPrompt
   set -l promptRoot $gitRoot
   set jjRoot $PWD
   while test -n "$jjRoot"
      if test -d "$jjRoot/.jj"
         break
      end
      set jjRoot (string replace -r '/[^/]*$' '' -- $jjRoot)
   end
   if test -n "$jjRoot"; and command -sq jj
      set -l useJj false
      if test "$jjRoot" != "$gitRoot"
         set useJj true
      else if not command git symbolic-ref --quiet HEAD >/dev/null 2>&1
         set useJj true
      end
      if test "$useJj" = true
         set gitPrompt (fish_jj_prompt)
         if test -n "$gitPrompt"
            set promptRoot $jjRoot
         end
      end
   end
   if test -z "$gitPrompt"
      set gitPrompt (fish_git_prompt '%s')
   end

   if [ -n "$gitPrompt" ]
      set gitDir (basename "$promptRoot")
      set repoName (basename -s .git (git config --get remote.origin.url) 2>/dev/null || hostname)
      set gitStart "git@$repoName:"
      set dir (string match -r "$gitDir.*" -- "$dir")
   else
      set gitStart ""
      set gitPrompt ""
   end

   echo -es $topPromptStart $gitStart (set_color --bold blue) $dir (set_color normal) ' ' $gitPrompt
   echo -es $bottomPromptStart $modeIndicator $time ' ' $userAndHost ' ' $statusColor $promptEnd (set_color normal) ' '
end
