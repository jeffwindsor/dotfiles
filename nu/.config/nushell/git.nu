def git-pull [path] { run-external "git" "-C" $path "pull" "--quiet" }
alias gg = lazygit
alias gd = git diff --word-diff --unified=0
alias gb = git blame -w -C -C -C
alias gs = git status
alias gph = git push
alias gpl = git pull

def --env git-clone [repo_url:string] {
	let repo = ($repo_url | parse --regex '(?:git@(?P<git_host>[^:]+)):?(?P<repo_path>.+?)(?:\.git)?$')
  let target = $'($env.SOURCE)/($repo.git_host)/($repo.repo_path)'
  
	git clone $repo_url $target
	cd $target
	ls -a
}

