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

The directory name (e.g., `nu/`, `zellij/`, `nvim/`) maps to what will be stowed into `$HOME`.

### Key Tool Directories

- **nu/** - Nushell shell configuration with modular autoload system
- **nvim/** - LazyVim-based Neovim configuration
- **zellij/** - Terminal multiplexer with custom layouts and keybindings
- **bash/**, **zsh/** - Shell configurations for Bash and Zsh
- **git/** - Git configuration
- **brew/** - Homebrew bundle files (per-machine Brewfiles)
- **ghostty/**, **alacritty/**, **kitty/** - Terminal emulator configs
- **yazi/**, **lazygit/** - File manager and git TUI
- **hx/**, **zed/** - Text editor configurations (Helix, Zed)
- **starship/** - Shell prompt configuration
- **mise/** - Development environment/runtime manager
- **exocortex/** - Personal notes and documentation

## Nushell Configuration Architecture

The primary shell is **Nushell**. The configuration uses an **autoload module system**:

### Main Config Files
- `nu/.config/nushell/config.nu` - Main configuration (84 lines)
- `nu/.config/nushell/env.nu` - Environment variables (mostly deferred to config.nu)
- `nu/.config/nushell/autoload/*.nu` - 16 modular configuration files

### Important Environment Variables
```nushell
$env.SOURCE = ~/Source                              # All source code
$env.SOURCE_GITHUB = ~/Source/github.com
$env.SOURCE_JEFF = ~/Source/github.com/jeffwindsor
$env.DOTFILES = ~/Source/github.com/jeffwindsor/dotfiles

$env.EDITOR = "hx"                                  # Helix editor
$env.VISUAL = "zed"                                 # Zed editor
```

### Key Autoload Modules
- `dotfiles.nu` - Dotfiles management aliases (`d`, `de`, `dv`, `ds`, `dg`)
- `git.nu` - Git workflow helpers
- `neovim.nu`, `helix.nu` - Editor shortcuts
- `zellij.nu`, `yazi.nu` - TUI application helpers
- `homebrew.nu`, `mise.nu` - Package/runtime management

### Custom Functions in config.nu
- `cdl [path]` - Change directory with auto-clear and list
- Color/print utilities: `header`, `section`, `info`, `warning`, `fail`, `success`

## Zellij Configuration

Terminal multiplexer configured in `zellij/.config/zellij/config.kdl`:

- **Theme**: `iceberg-dark`
- **Default layout**: `compact`
- **Custom layouts**: `claude.kdl`, `dev.kdl` in `layouts/` subdirectory
- **Vim-style keybindings**: hjkl navigation throughout
- **Startup tips disabled**: `show_startup_tips false`

## Common Development Commands

### Dotfiles Management (Nushell aliases)
```bash
d       # cd to $DOTFILES with list
de      # Edit dotfiles in Helix
dv      # Edit dotfiles in Zed
ds      # Edit Nushell config specifically
dg      # Launch lazygit in dotfiles directory
```

### Working with Configurations

This repository uses **GNU Stow** for deployment:

```bash
# Stow a single tool configuration
cd ~/Source/github.com/jeffwindsor/dotfiles
stow nu              # Deploy Nushell config to ~/.config/nushell/
stow nvim            # Deploy Neovim config to ~/.config/nvim/

# Unstow (remove symlinks)
stow -D nu           # Remove Nushell symlinks

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

### Modular Nushell Configuration
When modifying Nushell config, prefer adding new modules to `autoload/` rather than expanding `config.nu`. Each autoload file should focus on a single tool or concern.

### Machine-Specific Configurations
Some tools (like Homebrew, Claude) have machine-specific subdirectories named with machine identifiers.

### Git Workflow
The repository tracks configuration files but ignores:
- Nushell history (`nu/.config/nushell/history.txt`)
- macOS metadata (`.DS_Store`, `._*`, `.Spotlight-V100`, `.Trashes`)
