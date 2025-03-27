#! /usr/bin/env bash
source="${1:-$DOTFILES}"
target="${2:-$HOME}"

# map package name to command, for later overrides
overrides=(
  "helix;hx"
  "nixpkgs;nix"
  "nushell;nu"
  "ripgrep;rg"
  "television;tv"
  "ghostty;ls"  # cannot seem to find ghostty in cli, so just punting with a known commands
)
echo -e "\e[94m== Dotfile Sync ( with stow) ==\e[0m"
echo "Source: $source"
echo "Target: $target"

# for each directory in source
for path in $(fd -td -d1 "" "$source"); do
  package=$(basename $path)
  
  # default values
  check_command="$package"
  
  # check for override match
  for o in "${overrides[@]}"; do
    split=(${o//;/ }) # split override entry by semi-colon
    
    # look for match, override command if found
    if [[ "$package" == "${split[0]}" ]]; then
      check_command="${split[1]}"
      break
    fi
   
  done;

  # only stow packages where command is active
  if command -v "$check_command" &>/dev/null; then
    echo -e "\e[0;32m $package: Clean and Restore $package \e[0m"
    stow -S --dir="$source" --target="$target" "$package"
  else
    echo -e "\e[0;31m $package: $check_command not found, Clean only \e[0m"
    stow -D --dir="$source" --target="$target" "$package"
  fi
done;

