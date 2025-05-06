#!/usr/bin/env bash
source="${1:-$DOTFILES}"
target="${2:-$HOME}"

echo -e "${BG_LIGHTBLUE}${FG_BLACK}== Dotfile Sync ==${NC}"
echo -e "${FG_LIGHTBLUE}Source: $source${NC}"
echo -e "${FG_LIGHTBLUE}Target: $target${NC}"

# for each non-hidden directory in source
# for path in $(fd -td -d1 "" "$source"); do
for path in $(find "$source" -mindepth 1 -maxdepth 1 -type d -not -path "*/\.*"); do
	package=$(basename "$path")

	# only sync packages where package's command is installed
	if command -v "$package" &>/dev/null; then
		echo -e "${FG_LIGHTGREEN} $package: synced ${NC}"
		stow -S --dir="$source" --target="$target" "$package"
	else
		echo -e "${FG_GRAY} $package: not installed ${NC}"
		stow -D --dir="$source" --target="$target" "$package"
	fi
done
