#!/usr/bin/env zsh

# ═══════════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════════

# Claude Bedrock configuration
claude-bedrock-direct() {
  export ANTHROPIC_MODEL="sonnet"
  export ANTHROPIC_SMALL_FAST_MODEL="haiku"

  echo "setting models to $ANTHROPIC_MODEL : $ANTHROPIC_SMALL_FAST_MODEL"
  ~/.config/claude/bedrock.sh
}

claude-bedrock-direct-opus() {
  export ANTHROPIC_MODEL="opus"
  export ANTHROPIC_SMALL_FAST_MODEL="haiku"

  echo "setting models to $ANTHROPIC_MODEL : $ANTHROPIC_SMALL_FAST_MODEL"
  ~/.config/claude/bedrock.sh
}


# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias aa='claude'
alias a='claude-dev'
alias cb='claude-bedrock-direct'
alias cbo='claude-bedrock-direct-opus'
alias cbb='~/bin/claudecode'
#alias cb='~/bin/claudecode'
#alias claude-bedrock='~/bin/claudecode'

