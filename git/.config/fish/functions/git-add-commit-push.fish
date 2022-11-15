function git-add-commit-push 
  git add --all
  git-commit "$argv[1]"
  git push
end
