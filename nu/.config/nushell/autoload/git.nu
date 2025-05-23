# repos / source files
alias src = cdl $env.SOURCE 
alias srcs = cdl (tv git-repos)
alias hub = cdl $env.SOURCE_GITHUB 
alias lab = cdl $env.SOURCE_GITCJ 
alias empire = cdl ($env.SOURCE_GITCJ | path join "empire") 
alias jeff = cdl $env.SOURCE_JEFF 

# git
alias gg = lazygit
alias gd = git diff --word-diff --unified=0
alias gb = git blame -w -C -C -C
alias gs = git status
alias gph = git push
alias gpl = git pull
alias gl = git log --pretty=%h»¦«%aN»¦«%s»¦«%ch
	| lines
	| split column "»¦«" sha1 committer desc merged
	| update merged {|x| $x.merged | into datetime }
	| first 20

def git-pull [path] {
	git -C $path pull
}

def git-repos [root_path] {
	let target = [$root_path "**/.git"] | str join "/" | into glob
	ls -a $target
}

def --env git-clone [repo_url:string] {
	let repo = ($repo_url | parse --regex '(?:git@(?P<git_host>[^:]+)):?(?P<repo_path>.+?)(?:\.git)?$')
  let target = $'($env.SOURCE)/($repo.git_host)/($repo.repo_path)'
  
	git clone $repo_url $target
	cd $target
	ls -a
}

