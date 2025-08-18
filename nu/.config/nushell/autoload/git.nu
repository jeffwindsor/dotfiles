# repos / source files
alias src = cdl $env.SOURCE 
alias srcs = cdl (tv git-repos)
alias hub = cdl $env.SOURCE_GITHUB 
alias lab = cdl $env.SOURCE_GITCJ 
alias empire = cdl ($env.SOURCE_GITCJ | path join "empire") 
alias jeff = cdl $env.SOURCE_JEFF 

# git
alias gb = git blame -w -C -C -C
alias gd = tv git-diff
alias gg = lazygit
alias gl = tv git-log
alias gph = git push
alias gpl = git pull
alias gr = tv git-reflog
alias gs = git status

# Git pull applied to repo at path
def git-pull [path] {
	git -C $path pull
}

# List all git repos
def git-repos [root_path] {
	let target = [$root_path "**/.git"] | str join "/" | into glob
	ls -a $target
}

# Personal Git Clone Wrapper
#
# will make sure the repo is put into my source folder with this grammer:
# source/<git host>/<repo name without .git>
# for gitlab this can be a repo name with subfolders
def --env git-clone [repo_url:string] {
	let repo = ($repo_url | parse --regex '(?:git@(?P<git_host>[^:]+)):?(?P<repo_path>.+?)(?:\.git)?$')
  let target = $'($env.SOURCE)/($repo.git_host.0)/($repo.repo_path.0)'
  
	git clone ($repo_url) ($target)
	cd $target
	ls -a
}

