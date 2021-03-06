#!/usr/bin/env bash
set -e
cd "$(dirname "${0}")"

ln -sf "$PWD/zshenv" "$HOME/.zshenv"
ln -sf "$PWD/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config/picom"
ln -sf "$PWD/picom.conf" "$HOME/.config/picom/picom.conf"

mkdir -p "$HOME/.config/alacritty"
ln -sf "$PWD/alacritty-base.yml" "$HOME/.config/alacritty/base.yml"

ln -sf "${HOME}/.config/gitignore" "$HOME/.gitignore"
ln -sf "${HOME}/.config/git/personal.gitconfig" "$HOME/.gitconfig"
ln -sf "${HOME}/.config/ssh/personal.config" "$HOME/.ssh/config"

