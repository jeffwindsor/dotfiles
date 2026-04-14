# Project Backlog

Items captured during feature work that are out of scope for the current feature.

---

## Current
- [ ] 
- [ ] Investigate and fix tinty lazygit not writing theme file
  - **What `theme()` does step by step:**
    1. **Guard check** — if `~/.local/share/tinted-theming/tinty` doesn't exist, bail and prompt `theme-sync` first
    2. **Pick a source** — fzf menu: `Favorites` or `All Themes`; Escape exits cleanly
    3. **Pick a theme** — Favorites reads `~/.config/tinted-theming/tinty/favorites`; All Themes runs `tinty list`; Escape exits cleanly
    4. **Apply** — calls `tinty apply <selected>`, which fires all `[[items]]` hooks in `config.toml`: copies color files for Alacritty, Ghostty, Kitty, tmux; sources the tinted-shell script; then runs the four hook scripts for Zellij, lsd, Yazi, and lazygit
  - **Likely issue:** `lazygit-theme.sh` constructs a path to `base16-lazygit/colors/<theme>.yml` relative to the tinted-shell scripts dir, but `base16-lazygit` is not an `[[items]]` entry in `config.toml` — it's never synced, so the file never exists and the copy silently fails

## 2026-04-11

- [x] Investigate Neovim 0.12 
  - [ ] minimax config
    - [x] Added
    - [ ] LSP, NVIM-LSPCONFIG, MASON, MASON-LSP-CONFIG, MASON-TOOL-INSTALLER
    - [ ] Fuzzy Finder
    - [ ] Completions
    - [ ] Color Scheme Picker and Random Rotation Function
    - [ ] Which-Key  

## 2026-04-10

- [x] Add fzf function to list and pick shell aliases with preview
  - Merged into `pick()` for combined display

- [x] Add fzf function to list and pick shell functions with preview
  - Merged into `pick()` for combined display

## Implementation: Combined `pick()` function

Added to `zsh/.config/zsh/50-user-modules.zsh`:
- `pick()` — Interactive fzf picker for both aliases and functions
- `alias p='pick'` — Shortcut to invoke picker
- `alias pp='pwd | pbcopy'` — Renamed from `p` (no longer conflicts)
- Removed: `query-aliases()`, `query-commands()`, `query-everything()`, and their aliases `qa`/`qc`/`qq`

**Features:**
- Single unified list with `[alias]` and `[func]` tags
- Preview shows alias expansion or full function body depending on type
- Escape cancels cleanly; Enter puts selection into ZLE buffer for editing
