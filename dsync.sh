#! /usr/bin/env bash
source="${1:-$DOTFILES}"
target="${2:-$HOME}"

echo -e "\e[94m== Dotfile Sync ==\e[0m"
echo "Source: $source"
echo "Target: $target"

# for each directory in source
# for path in $(fd -td -d1 "" "$source"); do

for path in $(find "$source" -maxdepth 1 -type d); do
	package=$(basename $path)

	# only sync packages where package's command is installed
	if command -v "$package" &>/dev/null; then
		echo -e "\e[0;32m $package: synced \e[0m"
		stow -S --dir="$source" --target="$target" "$package"
	else
		echo -e "\e[0;31m $package: not installed \e[0m"
		stow -D --dir="$source" --target="$target" "$package"
	fi
done
