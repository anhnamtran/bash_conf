if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_vi_cursor; end
export PATH="$PATH:$HOME/.spicetify"
fish_add_path /home/andrew_nt/.spicetify

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/andrew_nt/code/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

