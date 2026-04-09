# dotfiles

Requires [homebrew](https://brew.sh/) and [gnu stow](https://www.gnu.org/software/stow/) `brew install stow`

## Usage

### Clone repo

```sh
git clone https://github.com/jeffwindsor/dotfiles <repo target path>
```

### Syncing Packages 

#### Option 1: package by package (ie zsh, nvim, tmux, etc...)

```sh 
stow -S --dir "<repo target path>" --target "$HOME" <package>
```

#### Option 2: all installed sources

`dots-sync` is a function which manages your ~/.config links to the dotfiles repo.  It will link/unlink based on the install status of a program/package. Defaults to source=$DOTFILES but you can override with first parameter `dots-sync ~/some-location`.


```sh
source ./stow/.config/zsh/user-modules/stow.zsh
dots-sync
```


## How Syncing Works

Stow creates symlinks in the `$HOME` directory pointing back into your local cloned copy of this repo.
Allowing for version control while allowing the programs to find the configs where they expect.  Setting `DOTFILES` env variable to the path of your local cloned copy will be used as default source path in most functions as a usage simplification. 

## How I use it

* Each top-level folder represents a config `source`. 
* Each config `source`:
  * Represents a single package (e.g. zsh, rg, bat, etc..)
  * Root folder is named after the command not the package (e.g. rg not ripgrep)
  * Is linked ONLY if the package is installed
  * May add links to any sub folders in the `$HOME`.  (e.g zsh aliases and function files are distributed among multiple sources targeting `$HOME/.config/zsh/user-modules/`)
  * Will link all sub folders and files into the `$HOME`, for example, source of `rg/.config/ripgrep/` links to target as `~/.config/ripgrep/`
* Multiple hosts HACK: There are config `sources` named after hostnames (e.g. Midnight, MidnightSun) which hold per-machine overrides

## Packages of Note

* [Tinty](https://github.com/tinted-theming/tinty) from [tinted-theming](https://github.com/tinted-theming)
  * syncs all assigned terminal applications to the same color scheme (Base16 or Base24)
  * `theme` function gives a meta picker (fzf) for theme choice and application 

## Learn More about Dotfile Management

* [dotfile awesome list](https://github.com/webpro/awesome-dotfiles)
