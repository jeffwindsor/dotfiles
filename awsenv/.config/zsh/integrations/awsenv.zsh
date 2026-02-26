#!/usr/bin/env zsh
# CJ Engineering: awsenv
if command -v awsenv >/dev/null 2>&1 && command -v brew >/dev/null 2>&1; then
    local awsenv_init="$(brew --prefix awsenv)/share/awsenv/shell-init.bash"
    [ -f "$awsenv_init" ] && source "$awsenv_init"
fi
