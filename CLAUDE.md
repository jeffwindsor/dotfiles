# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a **dotfiles repository** managed with **GNU Stow** for symlink-based configuration deployment. Each top-level directory represents a separate application or tool configuration that can be independently stowed.

### Directory Organization Pattern

Each tool directory follows this structure:
```
<tool-name>/
  .config/<tool-name>/...   # XDG-compliant configuration files
```

The directory name (e.g., `zsh/`, `zellij/`, `nvim/`) maps to what will be stowed into `$HOME`.

### Key Tool Directories

- **zsh/** - Zsh shell configuration with modular functions system (PRIMARY SHELL)
- **bash/** - Bash shell configuration (fallback)
- **nvim/** - LazyVim-based Neovim configuration
- **zellij/** - Terminal multiplexer with custom layouts and keybindings
- **git/** - Git configuration
- **brew/** - Homebrew bundle files (per-machine Brewfiles)
- **ghostty/**, **alacritty/**, **kitty/** - Terminal emulator configs
- **yazi/**, **lazygit/** - File manager and git TUI
- **hx/**, **zed/** - Text editor configurations (Helix, Zed)
- **starship/** - Shell prompt configuration
- **mise/** - Development environment/runtime manager
- **exocortex/** - Personal notes and documentation

## Zsh Configuration Architecture

The primary shell is **Zsh**. The configuration uses a **modular functions system**:

### Main Config Files
- `zsh/.config/zsh/.zshrc` - Main configuration
- `zsh/.config/zsh/.zshenv` - Environment variables
- `zsh/.config/zsh/functions/*.zsh` - Modular function files

### Important Environment Variables
```bash
export SOURCE=~/Source
export SOURCE_GITHUB=~/Source/github.com
export SOURCE_JEFF=~/Source/github.com/jeffwindsor
export DOTFILES=~/Source/github.com/jeffwindsor/dotfiles

export EDITOR="hx"                                  # Helix editor
export VISUAL="zed"                                 # Zed editor
```

### Key Function Modules
- `claude.zsh` - Claude AI functions (`claude-dev`, `claude_bedrock`)
- `dotfiles.zsh` - Dotfiles management functions
- `git.zsh` - Git workflow helpers
- `zellij.zsh`, `yazi.zsh` - TUI application helpers
- `homebrew.zsh`, `mise.zsh` - Package/runtime management
- `core.zsh` - Core utilities and helpers

## Zellij Configuration

Terminal multiplexer configured in `zellij/.config/zellij/config.kdl`:

- **Theme**: `iceberg-dark`
- **Default layout**: `compact`
- **Custom layouts**: `claude.kdl`, `dev.kdl` in `layouts/` subdirectory
- **Vim-style keybindings**: hjkl navigation throughout
- **Startup tips disabled**: `show_startup_tips false`

## Common Development Commands

### Dotfiles Management (Zsh functions)
```bash
# Functions available from dotfiles.zsh
d       # cd to $DOTFILES
de      # Edit dotfiles in default editor
dv      # Edit dotfiles in Zed
dg      # Launch lazygit in dotfiles directory
```

### Claude AI Functions (from claude.zsh)
```bash
claude-dev      # Open dev layout in selected repo with Zellij
claude_bedrock  # Configure Claude Bedrock with Sonnet/Haiku models
```

### Working with Configurations

This repository uses **GNU Stow** for deployment:

```bash
# Stow a single tool configuration
cd ~/Source/github.com/jeffwindsor/dotfiles
stow zsh             # Deploy Zsh config to ~/.config/zsh/
stow nvim            # Deploy Neovim config to ~/.config/nvim/

# Unstow (remove symlinks)
stow -D zsh          # Remove Zsh symlinks

# Restow (refresh symlinks)
stow -R nvim         # Refresh Neovim symlinks
```

### Homebrew Management

Per-machine Brewfiles located at:
- `brew/.config/homebrew/Midnight/Brewfile`
- `brew/.config/homebrew/WKMZTAFD6544/Brewfile`

## Important Patterns

### XDG Base Directory Compliance
All configurations follow XDG standards with paths in `.config/` subdirectories.

### Modular Zsh Configuration
When modifying Zsh config, prefer adding new function modules to `functions/` rather than expanding `.zshrc`. Each function file should focus on a single tool or concern.

### Machine-Specific Configurations
Some tools (like Homebrew, Claude) have machine-specific subdirectories named with machine identifiers.

### Git Workflow
The repository tracks configuration files but ignores:
- Zsh history files (`.zsh_history`, `.zsh_sessions/`)
- macOS metadata (`.DS_Store`, `._*`, `.Spotlight-V100`, `.Trashes`)
