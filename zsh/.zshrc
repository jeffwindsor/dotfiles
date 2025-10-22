#!/usr/bin/env zsh
# .zshrc - Interactive Shell Configuration
# Read by: interactive shells only
  # zmodload zsh/zprof

ZSH_CONFIG_DIR="${DOTFILES}/zsh/.config/zsh"

# Load modules
#   plugins → options → keybindings → completions
#   Dependencies:
#     plugins before completions - completion system must exist before configuration
#     plugins before options - some options affect plugin behavior
#     options before keybindings - Some bindings depend on shell modes
#     keybindings before completions - Some completion widgets use keys
#     functions before aliases - aliases depend on functions
#     integrations last - external tools see complete config

#  Core modules
[[ -f "${ZSH_CONFIG_DIR}/plugins.zsh" ]] && source "${ZSH_CONFIG_DIR}/plugins.zsh"
[[ -f "${ZSH_CONFIG_DIR}/options.zsh" ]] && source "${ZSH_CONFIG_DIR}/options.zsh"
[[ -f "${ZSH_CONFIG_DIR}/keybindings.zsh" ]] && source "${ZSH_CONFIG_DIR}/keybindings.zsh"
[[ -f "${ZSH_CONFIG_DIR}/completions.zsh" ]] && source "${ZSH_CONFIG_DIR}/completions.zsh"

#  User Modules
for func in "${ZSH_CONFIG_DIR}"/functions/*.zsh; do
  [[ -f "$func" ]] && source "$func"
done
[[ -f "${ZSH_CONFIG_DIR}/aliases.zsh" ]] && source "${ZSH_CONFIG_DIR}/aliases.zsh"

#  Tool Modules
[[ -f "${ZSH_CONFIG_DIR}/integrations.zsh" ]] && source "${ZSH_CONFIG_DIR}/integrations.zsh"

# zprof
