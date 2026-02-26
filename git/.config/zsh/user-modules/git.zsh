#!/usr/bin/env zsh

git-ls-ignored(){
  git ls-files --ignored --cached --exclude-standard
}

git-rm-piped(){
  xargs git rm --cached
}
git-remove-from-history() {
    # Read files from stdin into array
    local files_to_remove=("${(@f)$(cat)}")

    if [ ${#files_to_remove[@]} -eq 0 ]; then
        echo "No files provided via stdin"
        return 1
    fi

    echo "Files to remove (${#files_to_remove[@]} total):"
    printf '   - %s\n' "${files_to_remove[@]}"
    echo ""

    # Check for git-filter-repo
    if ! command -v git-filter-repo &> /dev/null; then
        echo "git-filter-repo not installed"
        echo "Install: brew install git-filter-repo"
        return 1
    fi

    # Confirm
    echo "⚠  WARNING: This rewrites git history!"
    echo -n "Continue? (yes/no): " 
    read confirm < /dev/tty
    [[ "$confirm" != "yes" ]] && { echo "Aborted"; return 0; }

    # Create temp file and remove from history
    local temp_file=$(mktemp)
    printf '%s\n' "${files_to_remove[@]}" > "$temp_file"

    echo "<Removing files from git history..."
    git filter-repo --paths-from-file "$temp_file" --invert-paths --force
    rm "$temp_file"

    echo ""
    echo "Done! Next steps:"
    echo "   git push origin --force --all"
    echo "   git push origin --force --tags"
}

# Git rebase current branch to another
git-rebase-feature-branch(){
  #           Initial State    Final State
  # main:     A---B---C        A---B---C
  #                \                   \
  # feature:        D---E---F           D---E---F

  target="${1:-main}"
  feature=$(git branch --show-current)

  # Validate
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    return 1
  fi

  if ! git rev-parse --verify "$target" > /dev/null 2>&1; then
    echo "Error: Branch '$target' does not exist"
    return 1
  fi

  if ! git diff-index --quiet HEAD --; then
    echo "Uncommitted changes detected"
    git status --short
    return 1
  fi

  # Confirm
  echo "Rebase '$feature' onto '$target'?"
  read -p "(y/n) " -n 1 -r
  echo
  [[ ! $REPLY =~ ^[Yy]$ ]] && return 0

  # Execute
  git checkout "$target" && \
  git pull origin "$target" && \
  git checkout "$feature" && \
  git rebase "$target"
}

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
  local repo=$(tv my-git-repos)
  if [[ -n "$repo" ]]; then 
    cd "$repo"
    clear
    lsd -1A
  fi
}

# Select git repo with tv
git-workon-repo() {
  local repo=$(tv my-git-repos)
  if [[ -n "$repo" ]]; then 
    cd "$repo"
    zellij --layout claude
  fi
}


# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias gb='git blame -w -C -C -C'
alias gg='lazygit'
alias gs='git status'
alias gph='git push'
alias gpl='git pull'

alias gd='git-diff'
alias gl='git-log'
alias gr='git-reflog'

alias srcs='git-goto-repo'
alias srcx='git-workon-repo'
