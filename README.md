# Personal dotfiles (applied with GNU Stow)

My dotfiles in this repo are separated by `command` named folder in the root (think `rg` not `ripgrep`).  This is a personal choice so I could easily script the syncing of only installed command dotfiles, not a necessity.

Any files in the `command`` folder will be synced to the target directory by relative location.  So for example files in `rg/.config/ripgrep` with a target of `$HOME` will sync to `~/.config/ripgrep`.  There are special "machine name" folders, but that is just a hack so I can have different files per machine. 

Other options would be `chezmoi` or `yadm`, but for me `stow` is fine for now.


### Daily

* terminal - [alacritty](https://alacritty.org/) or [ghostty](https://ghostty.org/docs)
* multiplexer - [zellij](https://zellij.dev/)
* editor - [neovim](https://neovim.io/) with [lazyvim](https://www.lazyvim.org/) distro
* shell - zsh
* prompt - [starship](https://starship.rs/)
* files
  * [yazi](https://yazi-rs.github.io/features) - file manager
  * [bat](https://github.com/sharkdp/bat) - colorful `cat` replacement (lots of extras)
  * [eza](https://eza.rocks/) - colorful ls replacement (lots of extras)
* search 
  * fd - faster replacement for find (used by fzf and others)
  * fzf (with fzf-tab)
  * [tv](https://github.com/alexpasmantier/television) - for searching: git, docker, man, dotfiles, customs
  * ripgrep - faster replacement for grep

### Development

* package management - [mise](https://github.com/jdx/mise), a faster asdf
* source control - [lazygit](https://github.com/jesseduffield/lazygit), a great git TUI
* container - colima, docker, docker-buildx, lazydocker
* kubernetes - k9s kubernetes-cli kustomize


