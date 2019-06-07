##############################################################################
# Changes the prompt to a Debian-style one that truncates pwd to a max length
# depending on the terminal column width. Also uses the prompt_callback
# function of bash-git-prompt to set the window title to almost the same
# Debian-style. This version has been tweaked for Ubuntu standard terminal
# fonts.
#
# The prompt will use a Debian-style on the form
#
# relative-path-from-git-toplevel-dir bash-git-prompt-info <exit status>
# HH:MM:SS User@Host ▶
#
# The window title will have the form
# relative-path-from-git-toplevel-dir
#
# Example usage:
# if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
#   GIT_PROMPT_THEME=Custom
#   source ~/.bash-git-prompt/gitprompt.sh
# fi
#
# Based on Minimal UserHost by Imbibinebe <imbibinebe@gmail.com>
# [https://github.com/imbibinebe]
##############################################################################
override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Minimal_User_NoHost_NoExitStatus"

  #Overrides the prompt_callback function used by bash-git-prompt
  function prompt_callback {
    GIT_CONTAINER_FOLDER_FULLPATH=$(git rev-parse --show-toplevel 2> /dev/null)
    GIT_CONTAINER_FOLDER=$(basename $GIT_CONTAINER_FOLDER_FULLPATH 2> /dev/null)

    CURRENT_FULLPATH=$(pwd)
    CURRENT_BASE=$(basename $CURRENT_FULLPATH 2> /dev/null)

    # Distinguish between detached and not.
    if ! git symbolic-ref -q HEAD > /dev/null; then
      DETACHED=" ${BoldYellow}DETACHED${ResetColor}"
    fi

    local PS1="$GIT_CONTAINER_FOLDER"
    gp_set_window_title "$PS1"
    echo -n "→ ${BoldBlue}${PS1}${ResetColor}:${BoldBlue}${CURRENT_BASE}${ResetColor}"
  }

  Time12a="\$(date +%H:%M:%S)"
  if [ "$(id -u)" != "0" ]; then
     UserHost_Color="${BoldMagenta}"
  else
     UserHost_Color="${BoldRed}"
  fi

  GIT_PROMPT_BRANCH="${Yellow}"        # the git branch that is active in the current directory

  GIT_PROMPT_MASTER_BRANCH="${Red}${GIT_PROMPT_MASTER_BRANCH}" # used if the git branch that is active in the current directory is $GIT_PROMPT_MASTER_BRANCHES
  GIT_PROMPT_PREFIX=""                 # start of the git info string
  GIT_PROMPT_SUFFIX=""                 # the end of the git info string
  GIT_PROMPT_SEPARATOR=""              # separates each item
  GIT_PROMPT_STAGED=" ${BoldGreen}●"           # the number of staged files/directories
  GIT_PROMPT_CONFLICTS=" ${BoldRed}✖"       # the number of files in conflict
  GIT_PROMPT_CHANGED=" ${BoldBlue}✚"        # the number of changed files

  # GIT_PROMPT_REMOTE=" "                 # the remote branch name (if any) and the symbols for ahead and behind
  GIT_PROMPT_UNTRACKED=" ${Red}…"       # the number of untracked files/dirs
  GIT_PROMPT_STASHED=" ${Green}⚑ "    # the number of stashed files/dir
  GIT_PROMPT_CLEAN=" ${Green}✔ "      # a colored flag indicating a "clean" repo

  GIT_PROMPT_COMMAND_FAIL="${BoldRed}$"
  GIT_PROMPT_COMMAND_OK="${BoldGreen}$"

  local gp_end="\n${Time12a} ${UserHost_Color}$(whoami)${ResetColor}"

  GIT_PROMPT_START_USER="→ "
  GIT_PROMPT_END_USER="${gp_end} _LAST_COMMAND_INDICATOR_ "
  GIT_PROMPT_END_ROOT="${gp_end}/!!!\ "
}

reload_git_prompt_colors "Minimal_User_NoHost_NoExitStatus"
