#!/bin/bash

#== grep replacement: https://github.com/BurntSushi/ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"
# aliases
alias ar="alias | rg"
# environment
alias er="env | rg"
# functions
alias fr="declare -f | rg"

