#!/usr/bin/env zsh
# zellij.zsh - Zellij terminal multiplexer management

# ═══════════════════════════════════════════════════
# ZELLIJ
# ═══════════════════════════════════════════════════

# Kill all zellij sessions except current
zkill() {
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep -v "current" | \
    awk '{print $1}' | \
    xargs -I {} zellij kill-session {}
}

# Delete all exited zellij sessions
zdelete() {
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep "EXITED" | \
    awk '{print $1}' | \
    xargs -I {} zellij delete-session {}
}
