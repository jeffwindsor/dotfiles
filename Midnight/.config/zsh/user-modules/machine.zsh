#!/usr/bin/env zsh

# Sync everything
sync() {
  dots-pull
  zsh-sync
  brew-sync
  mise-sync
  dots-sync
}

