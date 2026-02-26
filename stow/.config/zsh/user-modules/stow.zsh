#!/usr/bin/env zsh
# stow.zsh - GNU Stow dotfiles management

dots-sync() {
    local source="$DOTFILES"
    local target="$HOME"
    local machine_name=$(networksetup -getcomputername | tr -d '\n')
    local dirs=("$DOTFILES"/*/)

    # print a header with useful information
    print_section "Syncing Dotfiles"
    print_muted "from: $source"
    print_muted "  to: $target"
    print_info  "  on: $machine_name"

    # dotfiles separated by command name (or machine name)
    for dir in "${dirs[@]}"; do
      [[ -d "$dir" ]] || continue

      # Make sure all installed packages (and machine) have dot files "installed" in home
      local package=$(basename "$dir")
      if command -v "$package" &> /dev/null; then
        # add/replace
        stow -S --dir "$source" --target "$target" "$package" 2>/dev/null
        print_success "$package"

      elif  [[ "$package" == "$machine_name" ]]; then
        # add/replace
        stow -S --dir "$source" --target "$target" "$package" 2>/dev/null
        print_info "** $package **"

      else
        # remove
        stow -D --dir "$source" --target "$target" "$package" 2>/dev/null
        print_muted "$package"
      fi
    done
}

alias d='cdl $DOTFILES'
alias de='cd $DOTFILES && nvim .'
alias dv='zed $DOTFILES'
alias dg='lazygit --path $DOTFILES'


