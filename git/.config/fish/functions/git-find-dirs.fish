function git-find-dirs
  # find all directories ending in .git (including hidden and ignored listings)
  fd '^.git$' $argv[1] -HIt d | sed 's/.git$//'
end
