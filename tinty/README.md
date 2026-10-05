# Tinty

[Tinty](https://github.com/tinted-theming/tinty) is a Base16/Base24 theme manager for coordinating color schemes across multiple terminal and CLI applications. It downloads pre-generated theme files from upstream repositories and uses signal-based live reloading so you never need to restart apps when switching themes.

## Quick Reference

Shell functions in `.config/zsh/user-modules/tinty.zsh`:

| Function | Purpose |
|----------|---------|
| `theme` | Switch themes interactively (television picker, favorites first); `theme <name>` applies directly |
| `sync-tinty` | Run `tinty sync` to install missing templates and update existing ones; also run in parallel by `sync` |
| `theme-list` | Print all favorited schemes |
| `theme-favorite` / `theme-unfavorite` | Manage the favorites list |

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

**`config.toml`** defines six active `[[items]]` — each is a theme source + hook pair:

| Item | Source Repository | Hook action |
|------|-------------------|-------------|
| `alacritty` | `tinted-terminal` | Copy theme file, touch config to trigger reload |
| `kitty` | `tinted-terminal` | Copy theme file, send USR1 signal |
| `zellij` | `tinted-shell` | Source palette, generate Zellij theme |
| `lsd` | `tinted-shell` | Source palette, generate lsd colors |
| `yazi` | `tinted-shell` | Source palette, generate Yazi flavor |
| `cosmic` | `tinted-shell` | Source palette, set COSMIC accent color (no-op if COSMIC is absent) |

(Commented out: `lazygit`, `tmux`. Ghostty and WezTerm were removed from tinty; their stowed configs no longer receive theme updates.)

When you run `tinty apply base16-nord`, tinty:
1. Resolves `<repo>/<themes-dir>/<scheme>.*` for each item
2. Executes each item's hook, passing the theme file path via `%f` placeholder

### How Each Application Gets Its Colors Updated

#### Alacritty
```toml
hook = "cp -f %f ~/.config/alacritty/colors.toml && touch ~/.config/alacritty/alacritty.toml"
```
Tinty copies the pre-generated Base16 theme into `colors.toml`. Alacritty watches its config file for modifications via inotify, so `touch alacritty.toml` (which includes `colors.toml`) triggers an immediate live reload without restarting.

#### Kitty
```toml
hook = "cp -f %f ~/.config/kitty/tinted-theming.conf && [ -n \"$KITTY_PID\" ] && kill -USR1 \"$KITTY_PID\""
```
Copies the theme to `tinted-theming.conf`, which `kitty.conf` includes via `include ./tinted-theming.conf`. Sends `USR1` to the Kitty process ID in `$KITTY_PID` to reload the config live.

#### Shell + App-Specific Themes

Four active items handle palette loading and app-specific theme generation. Each is self-contained:

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

**`cosmic`:**
```toml
hook = ". %f && bash ~/.config/tinted-theming/tinty/hooks/cosmic-color.sh"
```
Sources the palette, then converts `base0D` into the COSMIC desktop accent color. Exits without changes when `~/.config/cosmic` does not exist.

### Static Configuration References

Each app's stowed config contains a single fixed reference to its tinty-managed file. Tinty never modifies these — it only overwrites the *target* file, so apps always read the current theme without changes to their core config:

| App | Config reference |
|-----|---|
| **Kitty** | `kitty/config` → `include ./tinted-theming.conf` |
| **Zellij** | `zellij/config.kdl` → `theme "tinted-theming"` |

### Runtime-Generated Files (All Gitignored)

These files are created on every `tinty apply` and change with every theme switch. None are committed to the repository:

```
alacritty/.config/alacritty/colors.toml
kitty/.config/kitty/tinted-theming.conf
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

cosmic:
  ├─ . <repo>/scripts/base16-nord.sh
  ├─ bash ~/.config/tinted-theming/tinty/hooks/cosmic-color.sh
  │  └─ Sets the COSMIC accent color (skipped if COSMIC is absent)
  └─ ✓ Updates

Total time: < 200ms. All 6 active items applied without any restarts.
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

On first run, initialize with `sync-tinty` (`theme` reports when the tinty data directory is missing).
