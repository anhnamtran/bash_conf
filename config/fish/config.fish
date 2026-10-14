if status is-interactive
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    eval /home/andrew_nt/code/anaconda3/bin/conda "shell.fish" "hook" $argv | source
    # <<< conda initialize <<<
end

function fish_vi_cursor; end
fish_add_path /home/andrew_nt/.spicetify

