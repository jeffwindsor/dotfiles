# Personal dotfiles (applied with GNU Stow)

My [dotfiles](https://wiki.archlinux.org/title/Dotfiles) in this repo are separated by `command` named folder in the root (think `rg` not `ripgrep`).  This is a personal choice so I could easily script the syncing of only installed command dotfiles, not a necessity.

Any files in the `command` folder will be synced to the target directory by relative location.  So for example files in `rg/.config/ripgrep` with a target of `$HOME` will sync to `~/.config/ripgrep`.  There are special "machine name" folders, but that is just a hack so I can have different files per machine. 

Other options would be `chezmoi` or `yadm`, but for me `stow` + functions is fine.

---

## Some of my favorite packages...

* package manager (macos) - [homebrew](https://brew.sh/)

### GUI (macos)

* terminal - [alacritty](https://alacritty.org/) or [ghostty](https://ghostty.org/docs)
* tiling window "manager" - [aerospace](https://github.com/nikitabobko/AeroSpace)
* spotlight replacement - [raycast](https://raycast.com/)
* usb burner - [etcher](https://etcher.balena.io/)

### Terminal based

* terminal multiplexer - [zellij](https://zellij.dev/)
* editor - [nvim](https://neovim.io/) with [lazyvim](https://www.lazyvim.org/) distro
* shell - [zsh](http://zsh.org) with [zinit](https://github.com/zdharma-continuum/zinit), a fast zsh package manager
* prompt - [starship](https://starship.rs/)
* files
  * [yazi](https://yazi-rs.github.io/features) - file manager
  * [bat](https://github.com/sharkdp/bat) - colorful `cat` replacement (lots of extras)
  * lsd - colorful `ls` replacement (lots of extras)
* search 
  * [fd](https://github.com/sharkdp/fd) - faster replacement for find (used by `fzf` and others)
  * [fzf](https://github.com/junegunn/fzf) with [fzf-tab](https://github.com/Aloxaf/fzf-tab) - a better zsh completion menu
  * [tv](https://github.com/alexpasmantier/television) - fuzzy search of git, docker, man, dotfiles, and many more + custom
  * [rg](https://github.com/BurntSushi/ripgrep) - faster replacement for grep

#### Dev centric packages

* dev env package manager - [mise](https://github.com/jdx/mise), a faster asdf
* source control - [git](https://git-scm.com/), [lazygit](https://github.com/jesseduffield/lazygit) - a great git TUI
* containers - colima, docker, docker-buildx, lazydocker
* kubernetes - k9s, kubernetes-cli, kustomize


