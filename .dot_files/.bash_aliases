################## Specifically for mounted drives ##################
# classes in E Drive
alias classes="cd /media/andrew/Miscellaneous/Classes/Spring_2019/"
alias CHI="cd /media/andrew/Miscellaneous/Classes/Spring_2019/chin103/"
alias 484="cd /media/andrew/Miscellaneous/Classes/Spring_2019/cse484/"
alias 452="cd /media/andrew/Miscellaneous/Classes/Spring_2019/cse452/"
alias 374="cd /media/andrew/Miscellaneous/Classes/Spring_2019/cse374/"
alias Tellina-notes="cd /media/andrew/Miscellaneous/Research/tellina_user_study/"
alias Tellina-exp="cd /media/andrew/Miscellaneous/Research/tellina_infra/"

# Custom drives
alias resumes="cd /media/andrew/Miscellaneous/Projects/Resumes/"
alias cde="cd /media/andrew/Miscellaneous"
alias cdC="cd /media/andrew/C"

################## Should work for most Linux distributions ##################
alias miles="ssh atran35@miles.cs.washington.edu"
alias klaatu="ssh atran35@klaatu.cs.washington.edu"

# turns input command echo off
alias no-echo="stty -echo"

# quality of life
alias status="git status"
alias pull="git pull"
alias push="git push"
alias commit="git pull && git commit"
alias add="git add"

alias today="date +%Y-%m-%d"

alias clipboard="xargs echo -n | xclip -sel clip" # needs to have "xclip installed"
alias cpwd="pwd | clipboard"

alias mkdir="mkdir -pv"
alias rmf="rm -rf"

alias cdc="clear ; cd"
alias ..="cd .."
alias ~="cd ~ && clear"

alias q=exit
alias c=clear

alias open="xdg-open"
alias browser="sensible-browser"

alias trash="gvfs-trash"
alias lstrash="gvfs-ls trash://"

# listings
alias lt="ls -lt"
alias lss="ls -lSs"
alias l1="ls -1"
alias lv="vim ."

alias refresh="clear && source $HOME/.bashrc"

# permissions
alias cx="chmod +x"

# needs to have "tmux" installed
alias newmux="tmux new -s"
alias attachmux="tmux attach-session -t"
alias lsmux="tmux ls"

# needs to have "fancontrol" installed
alias startFanControl="sudo service fancontrol start"

# needs to have grip installed
alias grip="grip --quiet"
alias killGrip="pgrep -f \"grip\" | xargs kill"

# needs idea applications to be in PATH variables
alias intellij="idea.sh && q &"
alias pycharm="pycharm.sh && q &"

# Start vim with a Session file
alias vis="nvim -S"
alias vi="nvim"
alias vid="nvim -d"

# needs fzf installed
alias vzf="fzf | xargs nvim"
alias pzf="fzf | xargs zathura"
alias ozf="fzf | xargs xdg-open"

# needs to have jupyter note book installed in a virtualenv
JUPYTER=/media/andrew/Miscellaneous/Linux-Programs/jupyter-notebook
alias jupyter="svenv ${JUPYTER}/venv && jupyter"
