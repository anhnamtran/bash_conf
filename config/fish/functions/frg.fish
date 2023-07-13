# Function that lets one select files from result of ripgrep
function frg --description "Runs rg and subsequently pipes into fzf to open"
  if test $(count $argv) -lt 1;
    echo "Usage: frg <ripgrep arguments>"
    return 1
  end
  if ! type -q rg || ! type -q fzf || ! type -q bat;
    echo "rg, fzf, or bat not found"
    return 1
  end
  rg --line-number --no-heading --color=always --smart-case $argv \
    | fzf -d ':' -n 2.. --ansi --no-sort --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
    | xargs -d ':' fish -c '$EDITOR +$argv[2] $argv[1]'
end
