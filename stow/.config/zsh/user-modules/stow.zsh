#!/usr/bin/env zsh
# stow.zsh - GNU Stow dotfiles management

dots-sync() {
    # verify stow
    if ! command -v stow &> /dev/null; then
        echo "Error: stow not found. Install it via Homebrew (macOS) or your package manager (Linux)."
        return 1
    fi   

    local source="${1:-$DOTFILES}"
    local target="$HOME"
    local machine_name="${HOSTNAME:-$(hostname -s)}"
    local dirs=("$source"/*/)

    # print a header with useful information
    print_section "Syncing Dotfiles"
    print_muted "from: $source"
    print_muted "  to: $target"
    print_info  "  on: $machine_name"

    # dotfiles separated by command name (or machine name)
    for dir in "${dirs[@]}"; do
      [[ -d "$dir" ]] || continue

      # Make sure all installed packages (and machine) have dot files "installed" in home
      local package=$(basename "${dir,,}")  # Lowercase for consistency
      if command -v "$package" &> /dev/null; then
        # command installed: add/replace
        stow -S --dir "$source" --target "$target" "$package" 2>/dev/null
        print_success "$package"

      elif  [[ "$package" == "$machine_name" ]]; then
        # machine name matches: add/replace
        stow -S --dir "$source" --target "$target" "$package" 2>/dev/null
        print_info "** $package **"

      else
        # otherwise: remove
        stow -D --dir "$source" --target "$target" "$package" 2>/dev/null
        print_muted "$package"
      fi
    done
}

dots-sync-manual() {
  local source="$DOTFILES"
  local target="$HOME"

  [[ -d "$source" ]] || { echo "Error: Source dir '$source' not found"; return 1; }

  stow -S --dir "$source" --target "$target" "$@"

  for arg in "$@"; do
    print_info "$arg -> synced"
  done
}

alias d='cdl $DOTFILES'
alias de='cd $DOTFILES && nvim .'
alias dv='zed $DOTFILES'
alias dg='lazygit --path $DOTFILES'


