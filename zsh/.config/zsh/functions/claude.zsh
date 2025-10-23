#!/usr/bin/env zsh
# claude.zsh - Claude AI and development environment functions

# ═══════════════════════════════════════════════════
# CLAUDE / AI
# ═══════════════════════════════════════════════════

# Open Dev Mux in a repo
claude-dev() {
  local source=$(tv git-repos)
  cd "$source"
  zellij --layout claude
}

# Claude Bedrock configuration
claude_bedrock() {
  export ANTHROPIC_MODEL="sonnet"
  export ANTHROPIC_SMALL_FAST_MODEL="haiku"

  echo "node required for claude code"
  mise ls node

  echo "setting models to $ANTHROPIC_MODEL : $ANTHROPIC_SMALL_FAST_MODEL"
  ~/.config/claude/bedrock.sh
}
