#!/usr/bin/env zsh

# ═══════════════════════════════════════════════════
# FUNCTIONS
# ═══════════════════════════════════════════════════
# Name Zellij Panes after executable (ZSH Pre Exec hook)
update_pane_title() {
    local cmd="${1%% *}"
    local title="$1"
    case "$cmd" in
        nvim|vim) title="edit" ;;
        lazygit|gg|dg)  title="git"  ;;
        claude-bedrock|claude)  title="ai"   ;;
    esac
    printf '\033]0;%s\007' "$title"
}
if [[ -n "$ZELLIJ" ]]; then
    preexec() { update_pane_title "$1" }
fi


# Kill all zellij sessions except current
zkill() {
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep -v "current" | \
    awk '{print $1}' | \
    xargs -I {} zellij kill-session {}
}

# Delete all exited zellij sessions
zdelete() {
  zellij list-sessions --no-formatting 2>/dev/null | \
    grep "EXITED" | \
    awk '{print $1}' | \
    xargs -I {} zellij delete-session {}
}

# ═══════════════════════════════════════════════════
# ZELLIJ Provided
# ═══════════════════════════════════════════════════

# Plugin list - add new plugins here as "owner/repo"
_zellij_plugins=(
  "karimould/zellij-forgot"
  "dj95/zjstatus"
)

# Internal helper: Download a zellij plugin from GitHub
# Usage: _zellij_download_plugin owner repo
_zellij_download_plugin() {
  local owner="$1"
  local repo="$2"

  if [[ -z "$owner" || -z "$repo" ]]; then
    echo "✗ Usage: _zellij_download_plugin owner repo"
    return 1
  fi

  local plugin_dir="${HOME}/.local/share/zellij/plugins"

  # Create plugin directory if it doesn't exist
  mkdir -p "$plugin_dir"

  # Fetch latest release info from GitHub API
  local api_url="https://api.github.com/repos/${owner}/${repo}/releases/latest"
  local release_json

  echo "→ Fetching latest release info for ${owner}/${repo}..."
  release_json=$(curl -sL "$api_url")

  if [[ $? -ne 0 ]]; then
    echo "✗ Failed to fetch release information from GitHub"
    return 1
  fi

  # Extract the WASM download URL and filename from assets
  local download_url filename
  download_url=$(echo "$release_json" | grep -o '"browser_download_url": *"[^"]*\.wasm"' | head -1 | sed 's/.*"browser_download_url": *"\([^"]*\)".*/\1/')

  if [[ -z "$download_url" ]]; then
    echo "✗ Could not find WASM file in latest release"
    return 1
  fi

  # Extract filename from URL
  filename=$(basename "$download_url")
  local plugin_path="${plugin_dir}/${filename}"

  echo "→ Downloading from: $download_url"

  # Download the WASM file
  if curl -sL "$download_url" -o "$plugin_path"; then
    echo "✓ Successfully downloaded ${filename} to ${plugin_path}"
    return 0
  else
    echo "✗ Failed to download plugin"
    return 1
  fi
}

# Internal helper: Get expected filename for a plugin
# Usage: _zellij_plugin_filename owner repo
_zellij_plugin_filename() {
  local owner="$1"
  local repo="$2"
  local api_url="https://api.github.com/repos/${owner}/${repo}/releases/latest"
  local release_json

  release_json=$(curl -sL "$api_url" 2>/dev/null)
  if [[ $? -ne 0 ]]; then
    return 1
  fi

  local download_url
  download_url=$(echo "$release_json" | grep -o '"browser_download_url": *"[^"]*\.wasm"' | head -1 | sed 's/.*"browser_download_url": *"\([^"]*\)".*/\1/')

  if [[ -n "$download_url" ]]; then
    basename "$download_url"
  fi
}

# Internal helper: Process plugins with custom logic
# Usage: _zellij_process_plugins title action_fn
_zellij_process_plugins() {
  local title="$1"
  local action_fn="$2"
  local plugin_dir="${HOME}/.local/share/zellij/plugins"

  echo "════════════════════════════════════════"
  echo "$title"
  echo "════════════════════════════════════════"

  for plugin in "${_zellij_plugins[@]}"; do
    local owner="${plugin%%/*}"
    local repo="${plugin##*/}"

    echo ""
    echo "Processing ${owner}/${repo}..."

    # Get expected filename
    local filename
    filename=$(_zellij_plugin_filename "$owner" "$repo")

    if [[ -z "$filename" ]]; then
      echo "✗ Could not determine plugin filename"
      continue
    fi

    local plugin_path="${plugin_dir}/${filename}"

    # Call the action function with owner, repo, and plugin_path
    $action_fn "$owner" "$repo" "$plugin_path"
  done

  echo ""
  echo "════════════════════════════════════════"
  echo "Complete"
  echo "════════════════════════════════════════"
}

# Action function for sync - download only if missing
_zsync_action() {
  local owner="$1"
  local repo="$2"
  local plugin_path="$3"

  if [[ -f "$plugin_path" ]]; then
    echo "✓ Plugin already exists at ${plugin_path}"
  else
    echo "→ Plugin not found, downloading..."
    _zellij_download_plugin "$owner" "$repo"
  fi
}

# Action function for update - force download
_zupdate_action() {
  local owner="$1"
  local repo="$2"
  local plugin_path="$3"

  if [[ -f "$plugin_path" ]]; then
    echo "→ Removing existing plugin: $(basename "$plugin_path")"
    rm "$plugin_path"
  fi

  echo "→ Downloading latest version..."
  _zellij_download_plugin "$owner" "$repo"
}

# Action function for list plugins - show plugin status
_zlist_plugins_action() {
  local owner="$1"
  local repo="$2"
  local plugin_path="$3"

  if [[ -f "$plugin_path" ]]; then
    echo "✓ Installed: $(basename "$plugin_path")"
  else
    echo "✗ Not installed"
  fi
}


# ═══════════════════════════════════════════════════
# ALIASES
# ═══════════════════════════════════════════════════
alias z='zellij'
alias zc='zellij --layout claude'
alias zd='zellij --layout dev'
alias zl='zellij ls'
alias zstatus='_zellij_process_plugins "Zellij Plugin Status" _zlist_plugins_action'
alias zsync='_zellij_process_plugins "Syncing Zellij Plugins" _zsync_action'
alias zupdate='_zellij_process_plugins "Updating Zellij Plugins" _zupdate_action'


