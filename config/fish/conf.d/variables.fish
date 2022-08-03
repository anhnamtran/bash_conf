# Disable the greeting
set -gx fish_greeting

set -gx me (whoami)
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx DIFFPROG "$EDITOR -d"

set -gx GIT_DISCOVERY_ACROSS_FILESYSTEM 1

set -gx RIPGREP_CONFIG_PATH ~/.ripgreprc
set -gx LESS "XRF"

set -gx FZF_DEFAULT_COMMAND "rg --smart-case --files --hidden --follow"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Ignore deprecation warnings for Python
set -gx PYTHONWARNINGS "ignore"

# Lower fish escape delay
set -gx fish_escape_delay_ms 10

set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
