#!/bin/bash

# Check if running on Fedora Atomic (Silverblue, Kinoite, etc.)
if rpm -q rpm-ostree >/dev/null 2>&1; then
  IS_ATOMIC=1
else
  IS_ATOMIC=0
fi

# Check if terra-release is installed
if rpm -q terra-release >/dev/null 2>&1; then
  echo "Terra repository is already installed."
  exit 0
fi

echo "Terra repository not found. Installing..."

if [[ $IS_ATOMIC -eq 1 ]]; then
  # Fedora Atomic installation
  echo "Detected Fedora Atomic. Installing via rpm-ostree..."
  curl -fsSL https://github.com/terrapkg/subatomic-repos/raw/main/terra.repo | pkexec tee /etc/yum.repos.d/terra.repo
  sudo rpm-ostree install terra-release
  echo "Installation complete. A reboot may be required."
else
  # Standard Fedora installation
  echo "Detected standard Fedora. Installing via dnf..."
  sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
  echo "Installation complete. Refreshing package store"
  sudo dnf --refresh upgrade
fi

sudo dnf install bat lsd fd git neovim ripgrep stow zsh kitty
sudo dnf install lazygit mise starship television yazi
