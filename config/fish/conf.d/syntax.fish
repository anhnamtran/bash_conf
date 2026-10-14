# Change syntax highlighting
# name: fish custom
set -g fish_color_normal normal
set -g fish_color_command blue --italics
set -g fish_color_quote green --bold
set -g fish_color_redirection cyan --bold
set -g fish_color_end yellow
set -g fish_color_error red --italics
set -g fish_color_param normal
set -g fish_color_comment brblack
set -g fish_color_match --background=brblue
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_color_history_current --bold
set -g fish_color_operator brblack
set -g fish_color_escape brcyan
set -g fish_color_cwd green
set -g fish_color_valid_path green
set -g fish_color_cwd_root red
set -g fish_color_user brgreen
set -g fish_color_autosuggestion 555 brblack
set -g fish_color_host normal
set -g fish_color_cancel -r
set -g fish_color_option brwhite
set -g fish_color_keyword magenta
set -g fish_color_host_remote yellow
set -g fish_color_status red

# pager colors (moved from fish 4.3's fish_frozen_theme.fish)
set -g fish_pager_color_completion normal
set -g fish_pager_color_description B3A06D yellow -i
set -g fish_pager_color_prefix normal --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r
