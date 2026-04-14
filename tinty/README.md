# Tinty

[Tinty](https://github.com/tinted-theming/tinty) is a Base16/Base24 theme manager for coordinating color schemes across multiple terminal and CLI applications. It downloads pre-generated theme files from upstream repositories and uses signal-based live reloading so you never need to restart apps when switching themes.

## Quick Reference

Three shell functions in `.config/zsh/integrations/tinty.zsh` cover all normal usage:

| Function | Purpose |
|----------|---------|
| `tinty-setup` | First-time setup: syncs all theme repos then opens the theme picker |
| `tinty-update` | After a config change: syncs new repos and re-applies the current theme |
| `theme` | Switch themes interactively via FZF; prompts to run `tinty-setup` if not yet initialized |

Additional functions:
- `theme-sync` — run `tinty sync` to pull upstream repos
- `theme-list` — print all favorited schemes
- `theme-favorite` / `theme-unfavorite` — manage the favorites list

---

## Technical Architecture

### What is Base16/Base24?

Base16/Base24 is a color scheme convention that defines a fixed palette of 16 (Base16) or 24 (Base24) named color slots:

```
base00 — default background      base08 — error/red
base01 — lighter background      base09 — warning/orange
base02 — selection/highlight     base0A — notice/yellow
...
base07 — default foreground      base0F — magenta/special
```

The ecosystem provides pre-generated theme files in each application's native format. Tinty's role is to centrally manage switching between these themes across all your apps.

### Configuration Structure

**`config.toml`** defines eight `[[items]]` — each is a theme source + hook pair:

| Item | Source Repository | Hook action |
|------|-------------------|-------------|
| `alacritty` | `tinted-terminal` | Copy theme file, touch config to trigger reload |
| `kitty` | `tinted-terminal` | Copy theme file, send USR1 signal |
| `zellij` | `tinted-shell` | Source palette, generate Zellij theme |
| `lsd` | `tinted-shell` | Source palette, generate lsd colors |
| `yazi` | `tinted-shell` | Source palette, generate Yazi flavor |
| `lazygit` | `tinted-shell` | Source palette, copy/generate lazygit theme |

(Commented: `ghostty`, `tmux`)

When you run `tinty apply base16-nord`, tinty:
1. Resolves `<repo>/<themes-dir>/<scheme>.*` for each item
2. Executes each item's hook, passing the theme file path via `%f` placeholder

### How Each Application Gets Its Colors Updated

#### Alacritty
```toml
hook = "cp -f %f ~/.config/alacritty/colors.toml && touch ~/.config/alacritty/alacritty.toml"
```
Tinty copies the pre-generated Base16 theme into `colors.toml`. Alacritty watches its config file for modifications via inotify, so `touch alacritty.toml` (which includes `colors.toml`) triggers an immediate live reload without restarting.

#### Ghostty
```toml
hook = "mkdir -p ~/.config/ghostty/themes && cp -f $TINTY_THEME_FILE_PATH ~/.config/ghostty/themes/tinted-theming && killall -SIGUSR2 ghostty 2>/dev/null || true"
```
Copies the theme file to a fixed location. Your `ghostty/config` has `theme = tinted-theming`, so Ghostty always looks in that directory. The `SIGUSR2` signal tells all running Ghostty processes to reload their config live.

#### Kitty
```toml
hook = "cp -f %f ~/.config/kitty/tinted-theming.conf && [ -n \"$KITTY_PID\" ] && kill -USR1 \"$KITTY_PID\""
```
Copies the theme to `tinted-theming.conf`, which `kitty.conf` includes via `include ./tinted-theming.conf`. Sends `USR1` to the Kitty process ID in `$KITTY_PID` to reload the config live.

#### Tmux
```toml
hook = "tmux run 2>/dev/null && tmux source-file %f"
```
Directly sources the theme file into the running tmux server via `source-file`. No intermediate file needed — tmux applies it to all active sessions immediately.

#### Shell + App-Specific Themes

Four separate items handle palette loading and app-specific theme generation. Each is self-contained:

**`zellij`:**
```toml
hook = ". %f && bash ~/.config/tinted-theming/tinty/hooks/zellij-theme.sh"
```
Sources the palette script (exports Base16/Base24 palette variables and repaints terminal colors via ANSI escape sequences), then reads 12 slots and generates `~/.config/zellij/themes/tinted-theming.kdl`.

**`lsd`:**
```toml
hook = ". %f && bash ~/.config/tinted-theming/tinty/hooks/lsd-colors.sh"
```
Sources the palette, then reads 10 slots and generates `~/.config/lsd/colors.yaml` for directory listings.

**`yazi`:**
```toml
hook = ". %f && bash ~/.config/tinted-theming/tinty/hooks/yazi-flavor.sh"
```
Sources the palette, then reads 13 slots and generates `~/.config/yazi/flavors/tinted-scheme.yazi/flavor.toml`.

**`lazygit`:**
```toml
hook = ". %f && bash ~/.config/tinted-theming/tinty/hooks/lazygit-theme.sh %f"
```
Sources the palette, then derives a lazygit path and copies/generates `~/.config/lazygit/theme.yml`, falling back to base16 for base24 themes.

### Static Configuration References

Each app's stowed config contains a single fixed reference to its tinty-managed file. Tinty never modifies these — it only overwrites the *target* file, so apps always read the current theme without changes to their core config:

| App | Config reference |
|-----|---|
| **Kitty** | `kitty/config` → `include ./tinted-theming.conf` |
| **Ghostty** | `ghostty/config` → `theme = tinted-theming` |
| **Zellij** | `zellij/config.kdl` → `theme "tinted-theming"` |

### Runtime-Generated Files (All Gitignored)

These files are created on every `tinty apply` and change with every theme switch. None are committed to the repository:

```
alacritty/.config/alacritty/colors.toml
ghostty/.config/ghostty/themes/tinted-theming
kitty/.config/kitty/tinted-theming.conf
lazygit/.config/lazygit/theme.yml
lsd/.config/lsd/colors.yaml
zellij/.config/zellij/themes/tinted-theming.kdl
yazi/.config/yazi/flavors/tinted-scheme.yazi/flavor.toml
```

---

## End-to-End Example

```
$ tinty apply base16-nord

alacritty:
  ├─ cp <repo>/themes/alacritty/base16-nord.toml → ~/.config/alacritty/colors.toml
  ├─ touch ~/.config/alacritty/alacritty.toml (inotify reload)
  └─ ✓ Updates

kitty:
  ├─ cp <repo>/themes/kitty/base16-nord.conf → ~/.config/kitty/tinted-theming.conf
  ├─ kill -USR1 $KITTY_PID
  └─ ✓ Updates

zellij:
  ├─ . <repo>/scripts/base16-nord.sh
  │  └─ Exports TINTY_SCHEME_PALETTE_BASE{00..17}_HEX_{R,G,B}
  │  └─ Sends ANSI escape sequences to terminal
  ├─ bash ~/.config/tinted-theming/tinty/hooks/zellij-theme.sh
  │  └─ Generates ~/.config/zellij/themes/tinted-theming.kdl
  └─ ✓ Updates

lsd:
  ├─ . <repo>/scripts/base16-nord.sh
  ├─ bash ~/.config/tinted-theming/tinty/hooks/lsd-colors.sh
  │  └─ Generates ~/.config/lsd/colors.yaml
  └─ ✓ Updates

yazi:
  ├─ . <repo>/scripts/base16-nord.sh
  ├─ bash ~/.config/tinted-theming/tinty/hooks/yazi-flavor.sh
  │  └─ Generates ~/.config/yazi/flavors/tinted-scheme.yazi/flavor.toml
  └─ ✓ Updates

lazygit:
  ├─ . <repo>/scripts/base16-nord.sh
  ├─ bash ~/.config/tinted-theming/tinty/hooks/lazygit-theme.sh
  │  └─ Generates ~/.config/lazygit/theme.yml
  └─ ✓ Updates

Total time: < 200ms. All 6 active applications themed without any restarts.
```

---

## Favorites System

**`~/.config/tinted-theming/tinty/favorites`** is a plain text file (one scheme name per line) used by the `theme` FZF picker to offer a curated shortlist before showing all 200+ available schemes. The picker first prompts "Favorites or All?" so you can switch to your most-used themes quickly.

Manage favorites with:
- `theme-favorite` — appends current scheme to favorites (sorted)
- `theme-unfavorite` — removes current scheme from favorites

---

## Installation

Tinty is installed via Homebrew:
```
brew tap tinted-theming/tinted
brew install tinty
```

On first run, initialize with `tinty-setup` (or just `theme`, which will prompt if not initialized).
