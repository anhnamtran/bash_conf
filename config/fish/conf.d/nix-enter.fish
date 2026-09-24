# Set up the fish_prompt to indicate the nix-shell environment
set -l --path old_path "$PATH"
if test -e "$HOME/.nix-profile/etc/profile.d/nix.fish"
  source "$HOME/.nix-profile/etc/profile.d/nix.fish"
end
fish_add_path -gpmP "$old_path"
fish_add_path -gamP "$HOME/.nix-profile/bin"
