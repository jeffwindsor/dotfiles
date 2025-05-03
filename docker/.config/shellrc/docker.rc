#!/bin/bash

#== docker
function docker_run_repo(){
	git_repo="$1"
	docker_image="$2"
	
	docker run -it --rm \
	-e HOME=/home/usr \
	-e XDG_CONFIG_HOME=/home/usr/.config \
	-v $HOME:/home/usr \
	-v $git_repo:/workspace \
	$docker_image
}

function docker_run_on_git_repo() {
	# pick from local git repos
	local git_repo=$(git-find-all-repos|fzf-display-basenames)
	if [ -n "$git_repo" ]; then
		# pick from all images
		local docker_image=$(docker images --format '{{.Repository}}:{{.Tag}}' | fzf --preview "docker image history --format '{{.CreatedBy}}' {}")
		if [ -n "$docker_image" ]; then
			# start a container of image with git repo mounted as /workspace
			docker_run_repo $git_repo $docker_image
		fi
	fi
}
	
function docker_build(){
	# select from dockerfiles
	local filepath=$(fd --glob "*.Dockerfile" $DOCKER_FILES | fzf --delimiter / --with-nth -1 --preview='eza -A {} | less')
	# tag as filename without extension
	local filename=$(basename "$filepath")
	local tag="${filename%.*}"
	# if filename given, build it
	[[ -n $filepath ]] && docker build -t $tag -f $filepath $DOCKER_FILES	
}

alias dbf="docker_build"
alias dl="docker container ls && docker image ls"
alias dpl="docker pull"
alias dri="docker run -it --rm"
alias dr="docker_run_on_git_repo \$SRC"
alias dr-g="docker_run \$SOURCE_JEFF/exercism exercism-gleam"

if command -v lazydocker &>/dev/null; then
	alias ld="lazydocker"
fi

