#!/usr/bin/env zsh
# idea.zsh - IntelliJ IDEA Vim configuration management

# ═══════════════════════════════════════════════════
# IDEA VIM
# ═══════════════════════════════════════════════════

idea_key() {
  local file="$1"
  local target="${HOME}/.ideavimrc"
  local source="${DOTFILES}/idea-ce/.config/jetbrains/${file}"

  if [[ ! -f "$source" ]]; then
    fail "Source file not found: $source"
    return 1
  fi

  ln -sF "$source" "$target"
  success "Linked ${file} to ${target}"
}
