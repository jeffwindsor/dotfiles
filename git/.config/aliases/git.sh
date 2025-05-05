#!/bin/bash

#== git (source control): https://github.com/git/git

# list git repo directories, selection changes to that directory
alias src="cd \$(git-find-all-repos|fzf-display-basenames) && l"

# Personal pretty format
#	Example output:  80adbf1 - Add dotfiles | Windsor, Jeff | 3 hours ago (HEAD -> main, origin/main)
export GIT_LOG_PRETTY_FORMAT='%C(green)%h%C(reset) - %s%C(cyan) | %an%C(dim) | %ch%C(auto)%d%C(reset)'

# Function to find all directories containing a .git subdirectory
git-find-all-repos() {
	# default to my source directory
	local root=${1:-$SOURCE}
	# prune will stop recurse on match, sed removes the '/.git' from the end of the result
	find "$root" -name .git -type d -prune | sed 's|/.git$||'
}

# Function to execute a git command on each Git repository
git-exec-on() {
	local repo
	while IFS= read -r repo; do
		echo "==> $repo"
		git -C "$repo" "$@"
	done
}

function array-to-string() {
	IFS=$'\n' # Use newline as delimiter
	local array_string
	array_string="${@[*]}"
	echo "$array_string"
}

alias gsync="echo -e '\e[94m== Spec Repo Sync ==\e[0m' && array-to-string \$REPOS_TO_SYNC | git-exec-on pull -v" # sync all listed git repos
alias gall="git-find-all-repos"  # list all repos
alias gall_x="clear && git-find-all-repos | git-exec-on" # exec git command on all repos	
alias gb="git blame -w -C -C -C" # git blame (more precise)
alias gbl="git blame -w -C -C -C -L" # git blame line range
alias gd="git diff --word-diff --unified=0" # git diff by words changed, minimal context
alias gl="git log --format=\$GIT_LOG_PRETTY_FORMAT"

alias gs="git status"
alias gss="gall_x status -s"		# shows terse status for all repositories
alias gsss="gall_x status"		# shows verbose status for all repositories
alias gpl="git pull"
alias gpls="gall_x pull"
alias gf="git fetch"
alias gph="git push"
alias gaa="git add --all"


alias ghub="git_clone_source 'github.com' "  # git clone from git hub to my source directory
alias glab="git_clone_source 'gitlab.cj.dev' "  # git clone from git work gitlab to my source directory
function git_clone_source() {
	local base_domain=$1  # 1 = base domain of source
	local repo_url=$2     # 2 = repo url, with or without the protocol and base domain
	
	# remove any un-needed prefixes
	repo=${repo_url#https://$base_domain/}
	repo=${repo#git@$base_domain:}
	repo=${repo%.git}

	clear
	echo -e "\e[94m==> cloning $repo_url into $SOURCE/$base_domain/$repo\e[0m"
	
	# clone repo to my source directory with full folder tree
	git clone "git@$base_domain:$repo.git" "$SOURCE/$base_domain/$repo"

	# change to the repo local directory, clear and ls -la
	cd "$SOURCE/$base_domain/$repo"
	lla
}

#== Lazygit (Git TUI): https://github.com/jesseduffield/lazygit ==
if command -v lazygit &>/dev/null; then
	alias gg="lazygit"
	alias ggg="lazygit --path \$( git-find-all-repos | fzf-display-basenames )"
	# alias lg="lazygit"
fi

