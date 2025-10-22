#!/usr/bin/env zsh
# mise.zsh - Mise runtime manager functions

# ═══════════════════════════════════════════════════
# MISE (runtime manager)
# ═══════════════════════════════════════════════════

mise-install-version() {
  local plugin="$1"

  if [[ -z "$plugin" ]]; then
    return
  fi

  local versions=$(mise ls-remote "$plugin")
  local version=$(echo -e "${versions}\nlatest" | sort -rV | tv --input-header "Select ${plugin} Version")

  if [[ -n "$version" ]]; then
    mise install "${plugin}@${version}"
  fi
}

mise-install() {
  local plugin="$1"

  if [[ -z "$plugin" ]]; then
    local asdfs=$(mise registry --backend asdf --hide-aliased)
    local cores=$(mise registry --backend core --hide-aliased)
    plugin=$(printf "%s\n%s" "$asdfs" "$cores" | tv --input-header "Select Plugin")
  fi

  mise-install-version "$plugin"
}

# Mise sync
mise-sync() {
  section "Mise: Syncing Global"
  local machine=$(networksetup -getcomputername | tr -d '\n')
  local source="${DOTFILES}/mise/.config/mise/${machine}/mise.local.toml"
  local target="${HOME}/mise.local.toml"
  ln -sf "$source" "$target"

  cd "$HOME"
  mise trust
  mise install
  cd - > /dev/null
}
