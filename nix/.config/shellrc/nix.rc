#!/bin/bash

#== Nix https://nixos.org/

# create a nix shell based on selected file 
function nix-develop-from-file() {
	local selection
	selection=$(fd -tf --glob "flake.nix" "$NIXSHELLS" | fzf --delimiter / --with-nth -2 | sd '/flake.nix' '')
	[[ -n $selection ]] && nix develop $selection
}

export NIXPKGS_ALLOW_UNFREE=1  # required for some use cases
# list all installed system packages
alias nl="nix-store -q --references /run/current-system/sw | sd '/nix/store/.+?-' '' | sort"
# create a new nix shell flake from a template.  usage: new <display-name>
alias nn="$NIXCONFIG/shells/new.sh"
alias nd="clear && nix develop"
# select env to create
alias ns="nix-develop-from-file"
# direct access to env creation
alias ns-r="nix develop \$NIXSHELLS/rust"
alias ns-d="nix develop \$NIXSHELLS/dotfiles"
alias ns-p="nix develop \$NIXSHELLS/python312"
alias ns-l="nix develop \$NIXSHELLS/ollama"
# create an env including specific packages
function nsp(){ nix develop nixpkgs#"$1"; }

# mix management aliases 
alias optimise="nix store optimise"
alias doctor="nix-store --verify --check-contents --repair"
if [ -d "/etc/nixos" ]; then
	#== nixos
	alias clean="nix-env --delete-generations && nix-collect-garbage"
	alias generations="sudo nix-env --list-generations --profile /nix/var/nix/profiles/system"
	alias rebuild="nixos-rebuild build --impure --flake \$NIXCONFIG"
	alias switch_only="sudo nixos-rebuild switch --impure --flake \$NIXCONFIG"
	# build and switch nix, pull important git repos, sync dotfile links
	alias switch="switch_only && gsync && dsync"
	alias upgrade="sudo nixos-rebuild switch --upgrade --impure --flake \$NIXCONFIG"

elif command -v darwin-rebuild &>/dev/null; then
	#== nix-darwin (using flakes)
	alias clean="nix store gc"
	alias generations="darwin-rebuild --list-generations"
	alias rebuild="darwin-rebuild build --impure --flake \$NIXCONFIG"
	alias switch="darwin-rebuild switch --impure --flake \$NIXCONFIG && bsync && gsync && dsync"
	alias update="nix flake update --flake \$NIXCONFIG"
fi
