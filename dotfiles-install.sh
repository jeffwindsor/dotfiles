#!/bin/bash

DOTFILES="$HOME/Source/github.com/jeffwindsor/startpage"

function Add-Homebrew() {
  eval "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function Add-Packages() {
  packages=(
    asdf
    bash
    bash-language-server
    bat
    black
    docker
    colima
    eza
    fastfetch
    fd
    fzf
    git
    helix
    lazygit
    neovim
    python-lsp-server
    ripgrep
    sd
    starship
    stow
    tldr
    tmux
    yazi
    zsh
    
    aerospace --cask
    balenaetcher --cask
    firefox --cask
    font-jetbrains-mono-nerd-font --cask
    google-chrome --cask
    keepingyouawake --cask
    spotify --cask
    sweet-home3d --cask
    vlc --cask
    allacritty --cask
    pearcleaner --cask
  )
  for p in "${packages[@]}"; do brew install "$p"; done
}

function Add-Work-Packages() {
  packages=(
    asdf
    aws-cdk
    awscli
    colima
    curl
    docker
    docker-credential-helper
    gitlab-ci-localk9s
    kubernetes-cli
    kubeseal
    lazydocker
    maven
    rlwrap
    sbt
    scala
    watch
    balenaetcher --cask
    tuple --cask
  )
  for p in "${packages[@]}"; do brew install "$p"; done
}

function Add-Dotfiles() {
  mkdir -p "$HOME/Source/github.com/"
  git clone git@github.com:jeffwindsor/dotfiles.git "$HOME/Source/github.com/jeffwindsor/dotfiles"
  git clone git@github.com:jeffwindsor/startpage.git "$DOTFILES"

  cd "$DOTFILES" || return
  stow . --target="$HOME"
  cd || return
}

function Force-Dotfile-Overwrite() {
  cd "$DOTFILES" || return
  stow . --target="$HOME" --adopt
  git restore .
  cd || return
}

PS3="Execute Setup Operation: "

select opt in All Add-Homebrew Add-Packages Add-Work-Packages Add-Dotfiles Force-Dotfile-Overwrite Quit; do
  case $opt in
  "All")
    Add-Homebrew
    Add-Packages
    Add-Dotfiles
    ;;
  "Add-Homebrew")
    Add-Homebrew
    ;;
  "Add-Packages")
    Add-Packages
    ;;
  "Add-Work-Packages")
    Add-Work-Packages
    ;;
  "Add-Dotfiles")
    Add-Dotfiles
    ;;
  "Force-Dotfile-Overwrite")
    Force-Dotfile-Overwrite
    ;;
  "Quit")
    break
    ;;
  *)
    echo "Unrecognized Option"
    ;;
  esac
done
