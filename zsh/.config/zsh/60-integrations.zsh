#!/usr/bin/env zsh
# ═══════════════════════════════════════════════════
# Load integration only if command is reachable.  
# user-modules expected to be named by the cammand 
# not the package name, ie `nvim.zsh` not `neovim.zsh`
# ═══════════════════════════════════════════════════
for func in "${ZSH_CONFIG_DIR}"/integrations/*.zsh; do
  local func_name=$(basename "$func" .zsh)
  source "$func"
done
