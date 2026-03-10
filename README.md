# dotfiles

Applied with [GNU Stow](https://www.gnu.org/software/stow/).

## Usage

```sh
brew install stow
git clone https://github.com/jeffwindsor/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow zsh git nvim  # or any package folder
```

## How it works
Stow creates symlinks in a `target` ($HOME in my case) pointing back into your local cloned copy of this repo.  Allowing for version control while allowing the programs to find the configs where they expect.

## How I use it

* Each top-level folder represents a config `source`.
* Each config `source`:
  * Represents a single package
  * Is named after the command not the package (rg, not ripgrep)
  * Is linked only if the package is installed on the local machine.
  * May add links to any sub folders in the `target`.  
      * See how zsh aliases and functions are distributed among multiple sources.
  * Will link all sub folders and files into the `target`, for example, source of `rg/.config/ripgrep/` links to target as `~/.config/ripgrep/`
* Automation: See `dots-sync` function in `stow/.config/zsh/user-modules/stow.zsh`
* Multiple hosts HACK: There are config `sources` named after hostnames (e.g. Midnight, MidnightSun) which hold per-machine overrides

## Learn More about Dotfile Management:
* [dotfile awesome list](https://github.com/webpro/awesome-dotfiles)
