#!/usr/bin/env zsh
# yazi.zsh - Yazi file manager integration

# ═══════════════════════════════════════════════════
# YAZI
# ═══════════════════════════════════════════════════

# Yazi with directory change support
yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if local cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
