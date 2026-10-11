# dotfiles

Per-program configs, linked into `$HOME` with [GNU Stow](https://www.gnu.org/software/stow/).

Requires `stow` and a package manager: [Homebrew](https://brew.sh/) on macOS (`brew install stow`), the system package manager on Linux.

## Setup

1. Clone to `~/Source/github.com/jeffwindsor/dotfiles`. `.zshenv` hard-codes `DOTFILES` to that path, so clone elsewhere only if you also change it.
2. Bootstrap the shell config: `stow -S --dir "$DOTFILES" --target "$HOME" zsh`, then open a new shell.
3. Run `sync-dots`.

`sync-dots` links every package whose command is installed and unlinks the rest. It defaults to `$DOTFILES`; pass another path to override (`sync-dots ~/some-location`). It lives in `stow/.config/zsh/user-modules/stow.zsh`.

To link a single package by hand: `stow -S --dir "$DOTFILES" --target "$HOME" <package>`.

## How it works

Stow symlinks files from this repo into `$HOME`, so the repo is version controlled and programs still find their configs where they expect.

* Each top-level folder is a package, named after the command, not the project (`rg`, not `ripgrep`).
* A package is linked only if its command is installed. Otherwise `sync-dots` unlinks it.
* Folder contents mirror `$HOME`: `rg/.config/ripgrep/ripgreprc` links to `~/.config/ripgrep/ripgreprc`.
* Packages can share a target folder. Aliases and functions from many packages land in `~/.config/zsh/user-modules/`.
* Folders named after a host (e.g. `Midnight`, `WKMZTAFD6544`) hold per-machine overrides such as the `Brewfile`. They are linked when the name matches `hostname -s`, case-insensitive.

## Notes

* [Tinty](https://github.com/tinted-theming/tinty) keeps terminal apps on one Base16/Base24 color scheme. The `theme` function is an fzf picker for choosing and applying one. See [tinty/README.md](tinty/README.md).
* Tinty output is generated per machine and gitignored, so some theme files exist only locally.
* More dotfile ideas: [awesome-dotfiles](https://github.com/webpro/awesome-dotfiles).
