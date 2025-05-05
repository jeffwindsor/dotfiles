#!/bin/bash

#== ASDF  https://asdf-vm.com/
alias async="asdf_sync"
alias al="asdf latest --all"
alias apa="asdf plugin list all | fzf  --header 'asdf plugin add' --preview '' --with-nth {1} | xargs asdf plugin add"
alias apr="asdf plugin list | fzf --header 'asdf plugin  remove' --preview '' | xargs plugin remove"
alias apl="asdf plugin list"
alias apu="asdf plugin update --all"
alias avi="asdf_version_install"

function asdf_version_install() {
	local name
	if [[ $# -eq 0 ]]; then
		name=$(asdf plugin list | fzf)
	else
		name=$1
	fi
	asdf install "$name" $({
		comm -23 \
			<(asdf list all "$name" | sort --version-sort) \
			<(asdf list "$name" | awk '{print $1}' | sort --version-sort)
		echo "latest"
	} | fzf --header="$name")
}

function asdf_add() {
	echo -e "${FG_LIGHTBLUE} ==> adding $1 version $2 ${NC}"
	asdf plugin add "$1"
	asdf install "$1" "$2"
	asdf set "$1" "$2"
}

function asdf_sync() {
	# do this in home directory so .tool_version is used globally
	cd

	machine=$(networksetup -getcomputername)
	echo "${FG_LIGHTBLUE}machine name: $machine ${NC}"
	echo -e "${FG_YELLOW} warning: validate this exists or add it ${NC}"
	echo -e "${FG_GRAY} export PATH='\${ASDF_DATA_DIR:-\$HOME/.asdf}/shims:\$PATH' >> .shellrc.local ${NC}"
	echo -e "${FG_LIGHTBLUE} == applying asdf config == ${NC}"

	# all machines - nothing yet

	# if [[ $machine == "Midnight Air" ]]; then
	# nothing yet
	# fi

	if [[ $machine == "WKMZTAFD6544" ]]; then
		asdf_add java corretto-21.0.7.6.1
		asdf_add maven 3.9.9
		asdf_add scala 2.12.18
		asdf_add nodejs 20.19.1
		asdf_add awscli 2.27.0
	fi

	cd - || return
}
