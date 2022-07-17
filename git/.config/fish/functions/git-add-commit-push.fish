function git-add-commit-push 
  git add --all
  if test -z $argv[1]
    git commit -m 'Refactor'
  else
    git commit -m "$argv[1]"
  end
  git push
end
