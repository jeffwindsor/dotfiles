#!/usr/bin/env zsh
# dotfiles.zsh - Dotfiles synchronization system

dots-pull() {
  print_section "Pulling Dotfiles"
  git -C "$DOTFILES" pull

  # Reload zsh config
  source ~/.zshrc

  # Reload app configs
  command -v aerospace &> /dev/null && aerospace reload-config 2>/dev/null
}

dots-sync() {
    local source="$DOTFILES"
    local target="$HOME"
    local machine_name=$(networksetup -getcomputername | tr -d '\n')
    local dirs=("$DOTFILES"/*/)

    # print a header with useful information
    print_section "Syncing Dotfiles"
    print_muted "from $source"
    print_muted "to   $target"
    print_muted "on $machine_name"

    # dotfiles separated by command name (or machine name)
    for dir in "${dirs[@]}"; do
      [[ -d "$dir" ]] || continue

      # Make sure all installed packages (and machine) have dot files "installed" in home
      local package=$(basename "$dir")
      if command -v "$package" &> /dev/null || [[ "$package" == "$machine_name" ]]; then
        # add/replace
        stow -S --dir "$source" --target "$target" "$package" 2>/dev/null
        print_success "$package"
      else
        # remove
        stow -D --dir "$source" --target "$target" "$package" 2>/dev/null
        print_muted "$package"
      fi
    done
  }
