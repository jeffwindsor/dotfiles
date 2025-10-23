#!/usr/bin/env zsh
# homebrew.zsh - Homebrew package management functions

# ═══════════════════════════════════════════════════
# HOMEBREW
# ═══════════════════════════════════════════════════

# List installed packages
brew-list() {
  section "Brew Formulae"
  brew leaves | sort
  echo ""
  section "Brew Casks"
  brew list --cask | sort
  echo ""
  section "Mise Installed"
  mise ls | tail -n +2 | awk 'NF'
}

# Brew diff - compare installed vs Brewfile
brew-diff() {
  local brewfile_path="${1:-$HOME/Brewfile}"

  if [[ ! -f "$brewfile_path" ]]; then
    fail "Brewfile not found at: $brewfile_path, skipping auto install of packages"
    return 1
  fi

  # Extract package names from Brewfile
  local formulae_bundled=($(grep '^brew "' "$brewfile_path" | sed 's/.*"\([^"]*\)".*/\1/' | sort))
  local casks_bundled=($(grep '^cask "' "$brewfile_path" | sed 's/.*"\([^"]*\)".*/\1/' | sort))

  # Get installed packages
  local formulae_installed=($(brew leaves | sort))
  local casks_installed=($(brew list --cask | sort))

  # Function to show differences
  show_diff() {
    local title="$1"
    shift
    local -a installed=("$@")

    # Split arrays - first half is installed, second half is bundled
    local split=$((($# + 1) / 2))
    local -a inst=("${@:1:$split}")
    local -a bund=("${@:$split+1}")

    # Find extras (installed but not in Brewfile)
    local -a extra=()
    for pkg in "${inst[@]}"; do
      if [[ ! " ${bund[@]} " =~ " ${pkg} " ]]; then
        extra+=("$pkg")
      fi
    done

    info "${title}:"
    if [[ ${#extra[@]} -eq 0 ]]; then
      dimmed "  (none)"
    else
      for pkg in "${extra[@]}"; do
        warning "  $(brew desc "$pkg" 2>/dev/null || echo "$pkg")"
      done
    fi

    normal "  Installed: ${#inst[@]}"
    normal "  Bundled:   ${#bund[@]}"
    normal "  Extra:     ${#extra[@]}"
    echo ""
  }

  show_diff "Formulae" "${formulae_installed[@]}" "${formulae_bundled[@]}"
  show_diff "Casks" "${casks_installed[@]}" "${casks_bundled[@]}"
}

# Brew sync - update and install from Brewfile
brew-sync() {
  local machine=$(networksetup -getcomputername | tr -d '\n')
  local brewfile="${HOME}/Brewfile"

  section "Homebrew"
  info "   Updating Database (update)"
  brew update

  info "   Upgrading Packages (upgrade)"
  brew upgrade

  info "   Installing Bundle described in $brewfile"
  brew bundle install --file="$brewfile"

  info "   Removing Orphaned Packages (autoremove)"
  brew autoremove

  info "   Cleaning Up Package Cache (cleanup)"
  brew cleanup

  info "   List installed but not bundled packages"
  brew-diff "$brewfile"
}
