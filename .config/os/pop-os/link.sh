#!/usr/bin/env bash
cd "$(dirname "${0}")"

ln -sf "$PWD/zshenv" "$HOME/.zshenv"
ln -sf "$PWD/zshrc" "$HOME/.zshrc"

mkdir -p "$HOME/.config/alacritty"
ln -sf "$PWD/alacritty/base.yml" "$HOME/.config/alacritty/base.yml"

ln -sf "$HOME/.config/gitignore" "$HOME/.gitignore"
ln -sf "$HOME/.config/git/personal.gitconfig" "$HOME/.gitconfig"
ln -sf "$HOME/.config/ssh/personal.config" "$HOME/.ssh/config"

#ln -sf "$HOME/.config/vscode/keybindings.json.macos" \
#       "$HOME/Library/Application Support/VSCodium/User/keybindings.json"
#ln -sf "$HOME/.config/vscode/settings.json.macos" \
#       "$HOME/Library/Application Support/VSCodium/User/settings.json"
