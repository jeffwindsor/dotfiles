#!/usr/bin/env zsh
# git.zsh - Git workflow and repository management functions

# ═══════════════════════════════════════════════════
# GIT FUNCTIONS
# ═══════════════════════════════════════════════════

# Git pull for specific repo
git-pull() {
  local path="$1"
  git -C "$path" pull
}

# List all git repos
git-repos() {
  local root_path="$1"
  find "$root_path" -type d -name ".git" -exec dirname {} \;
}

# Personal git clone wrapper
git-clone() {
  local repo_url="$1"

  # Parse git URL using regex - handles both SSH and HTTPS formats
  if [[ "$repo_url" =~ ^git@([^:]+):(.+)(\.git)?$ ]]; then
    local git_host="${match[1]}"
    local repo_path="${match[2]}"
  elif [[ "$repo_url" =~ ^https?://([^/]+)/(.+)(\.git)?$ ]]; then
    local git_host="${match[1]}"
    local repo_path="${match[2]}"
  else
    echo "Invalid git URL format. Expected: git@host:path or https://host/path"
    return 1
  fi

  # Remove trailing .git if present
  repo_path="${repo_path%.git}"

  local target="${SOURCE}/${git_host}/${repo_path}"

  git clone "$repo_url" "$target"
  cd "$target" && ls -A
}

# Git diff with tv (terminal viewer)
git-diff() {
  tv git-diff
}

# Git log with tv
git-log() {
  tv git-log
}

# Git reflog with tv
git-reflog() {
  tv git-reflog
}


git-goto-repo() {
  local repo=$(tv git-repos)
  if [[ -n "$repo" ]]; then 
    cd "$repo"
    eza -la
  fi
}

# Select git repo with tv
git-workon-repo() {
  local repo=$(tv git-repos)
  if [[ -n "$repo" ]]; then 
    cd "$repo"
    zellij --layout claude
  fi
}
