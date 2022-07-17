function git-log-graph
  if test -z $argv[1]
    git log --graph --pretty=format:$GIT_LOG_PRETTY_FORMAT --abbrev-commit --max-count=$argv[1]
  else
    git log --graph --pretty=format:$GIT_LOG_PRETTY_FORMAT --abbrev-commit --max-count=10
  end
end
