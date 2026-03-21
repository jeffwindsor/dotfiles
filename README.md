# dotfiles

Requires [homebrew](https://brew.sh/) and [gnu stow](https://www.gnu.org/software/stow/) `brew install stow`

## Usage

### Clone repo

```sh
git clone https://github.com/jeffwindsor/dotfiles <repo target path>
cd <repo target path>
```

### Sync option 1: by source 

```sh 
stow -S --dir "<repo target path>" --target "$HOME" <package>
```

### Sync option 2: all installed sources

Defaults to source=$DOTFILES but you can override with first parameter,

```sh
source ./stow/.config/zsh/user-modules/stow.zsh
dots-sync
```


## How it works

Stow creates symlinks in the `$HOME` dir pointing back into your local cloned copy of this repo.  
Allowing for version control while allowing the programs to find the configs where they expect.

## How I use it

* Each top-level folder represents a config `source`. 
* Each config `source`:
  * Represents a single package (e.g. zsh, rg, bat, etc..)
  * Root folder is named after the command not the package (e.g. rg not ripgrep)
  * Is linked ONLY if the package is installed
  * May add links to any sub folders in the `$HOME`.  (e.g zsh aliases and function files are distributed among multiple sources targeting `$HOME/.config/zsh/user-modules/`)
  * Will link all sub folders and files into the `$HOME`, for example, source of `rg/.config/ripgrep/` links to target as `~/.config/ripgrep/`
* Multiple hosts HACK: There are config `sources` named after hostnames (e.g. Midnight, MidnightSun) which hold per-machine overrides

## Learn More about Dotfile Management:

* [dotfile awesome list](https://github.com/webpro/awesome-dotfiles)
