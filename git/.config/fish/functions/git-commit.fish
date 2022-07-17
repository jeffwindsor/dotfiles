function git-commit
  if test -z $argv[1]
    git commit -m 'Refactor'
  else
    git commit -m "$argv[1]"
  end
end
