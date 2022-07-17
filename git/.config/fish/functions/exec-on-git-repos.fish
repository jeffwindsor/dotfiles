function exec-on-git-repos 
  # use fzf to get selection, and execute command on it
  set -l result (git-find-dirs $argv[2] | fzf --reverse)
  [ ! -z "$result" ] && $argv[1] $result
end
