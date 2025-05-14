#!/bin/bash
#== Homebrew https://brew.sh/

# Init
[[ -f "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# brew zsh completions
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

# Synchronize brews with dot file scripts
function bsync() {
	brew_sync "$@"
	brew upgrade -q
	if command -v asdf &>/dev/null; then
		asdf_sync
	fi
}

alias db="\$EDITOR \$DOTFILES/brews.sh"

# list all installed brews, opting to only show top level formulae
alias bl="echo '== Formulae ==' && brew leaves && echo '== Casks ==' && brew list --casks"

alias bn="brew install"
alias bi="brew info"
alias bs="brew search"
alias bup="brew upgrade"

function brew_sync() {

	FORMULAE=(
		asdf
		bash # macos has OLD version, replace
		bat
		eza
		fd
		fzf
		git
		helix
		lazygit
		ripgrep
		sd
		starship
		stow
		# television
		yazi # terminalfile manager
		zsh  # macos has OLD version, replace

		nushell  # modern shell
		carapace # completion library

		bash-language-server
		shfmt
		shellcheck

		# exercism
		# gleam
	)

	CASK=(
		firefox
		ghostty
		google-chrome
		jordanbaird-ice # bar icon manager
		keepingyouawake
		nikitabobko/tap/aerospace #i3 like tiling
		zed
		zen-browser

		claude
	)

	# add machine specific packages
	machine=$(networksetup -getcomputername)
	echo -e "${BG_LIGHTBLUE}${FG_BLACK} == brew sync on $machine == ${NC}"

	if [[ $machine == "Midnight Air" ]]; then
		CASK=(
			"${CASK[@]}"
			balenaetcher # usb iso app
			chatgpt
			discord
			iina
			spotify
			transmission
		)
	fi

	if [[ $machine == "WKMZTAFD6544" ]]; then
		FORMULAE=(
			"${FORMULAE[@]}"
			aws-cdk
			colima
			docker
			docker-buildx
			lazydocker
			maven
			visual-studio-code
		)
		CASK=(
			"${CASK[@]}"
			intellij-idea
			slack
			tuple
		)

	fi

	FORMULAE_INSTALLED=("$(brew leaves | col)") # leaves only shows top level packages, list shows all installed including dependencies
	FORMULAE_TO_INSTALL=($(comm -23 <(printf "%s\n" "${FORMULAE[@]}" | sort -u) <(printf "%s\n" "${FORMULAE_INSTALLED[@]}" | sort -u)))
	FORMULAE_TO_REMOVE=($(comm -23 <(printf "%s\n" "${FORMULAE_INSTALLED[@]}" | sort -u) <(printf "%s\n" "${FORMULAE[@]}" | sort -u)))

	CASK_INSTALLED=($(brew list --cask --full-name | col))
	CASK_TO_INSTALL=($(comm -23 <(printf "%s\n" "${CASK[@]}" | sort -u) <(printf "%s\n" "${CASK_INSTALLED[@]}" | sort -u)))
	CASK_TO_REMOVE=($(comm -23 <(printf "%s\n" "${CASK_INSTALLED[@]}" | sort -u) <(printf "%s\n" "${CASK[@]}" | sort -u)))

	function brew_command() {
		echo -e "${FG_LIGHTBLUE}==> Brew $* <==${NC}"
		eval "brew $*"
	}
	echo -e "== REQUESTED =="
	echo -e "${BG_GRAY}${FG_BLACK}formulaes${NC} ${FG_LIGHTGRAY} ${FORMULAE[*]} ${NC}"
	echo -e "${BG_GRAY}${FG_BLACK}casks    ${NC} ${FG_LIGHTGRAY} ${CASK[*]} ${NC}"
	echo -e "== INSTALL MISSING =="
	echo -e "${BG_GRAY}${FG_BLACK}formulaes${NC} ${FG_LIGHTGREEN} ${FORMULAE_TO_INSTALL[*]} ${NC}"
	echo -e "${BG_GRAY}${FG_BLACK}casks    ${NC} ${FG_LIGHTGREEN} ${CASK_TO_INSTALL[*]} ${NC}"
	for f in "${FORMULAE_TO_INSTALL[@]}"; do brew_command "install --formulae $f"; done
	for c in "${CASK_TO_INSTALL[@]}"; do brew_command "install --cask $c"; done

	if [[ -n $1 ]]; then
		echo -e "== REMOVE OTHERS =="
		echo -e "${BG_GRAY}${FG_BLACK}formulaes${NC} ${FG_LIGHTRED} ${FORMULAE_TO_REMOVE[*]} ${NC}"
		echo -e "${BG_GRAY}${FG_BLACK}casks    ${NC} ${FG_LIGHTRED} ${CASK_TO_REMOVE[*]} ${NC}"
		for f in "${FORMULAE_TO_REMOVE[@]}"; do brew_command "remove --formulae $f"; done
		for c in "${CASK_TO_REMOVE[@]}"; do brew_command "remove --cask $c"; done
	fi
}
