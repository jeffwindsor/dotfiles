#!/usr/bin/env zsh

export TERM=xterm-256color
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME}/zsh/"

# Load all modules in numbered order
for module in "${ZSH_CONFIG_DIR}"/*.zsh; do
  [[ -f "$module" ]] && source "$module"
done

# Load any machine specific configs
if [ -f $HOME/.zshrc.local ]; then
  source $HOME/.zshrc.local
fi
