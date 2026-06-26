#!/usr/bin/env zsh


fedora-sync() {
  sudo dnf upgrade --refresh -y 
}


# Sync everything
sync() {
  dots-pull
  zsh-sync
  fedora-sync
  dots-sync
}


