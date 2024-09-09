list:
  @just --list

_add-packages:
    #!/bin/bash
    packages=(
        bat
        bash
        eza
        fastfetch
        fd
        fzf
        git
        just
        lazygit
        neovim
        ripgrep
        sd
        starship
        stow
        tldr
        yazi
        zoxide
        zsh
        firefox --cask
        font-jetbrains-mono-nerd-font --cask
        font-droid-sans-mono-nerd-font --cask
        font-fira-code-nerd-font --cask
        google-chrome --cask
        spotify --cask
        qbittorrent --cask
        vlc --cask
        wezterm --cask
    )
    for p in "${packages[@]}"; do brew install "$p"; done

_add-ssh-keys:
    ssh-keygen -t ed25519 -f $HOME/.ssh/github.com -C "jeff.windsor@gmail.com"

add-repos:
    mkdir -p $HOME/Source/github.com/
    git clone git@github.com:jeffwindsor/dotfiles.git $HOME/Source/github.com/jeffwindsor/dotfiles
    git clone git@github.com:jeffwindsor/startpage.git $HOME/Source/github.com/jeffwindsor/startpage

[macos]
add-packages: 
    _add-packages
    brew install aerospace --cask
    brew install balenaetcher --cask
    brew install keepingyouawake --cask

[macos]
add-ssh-keys: 
    _add-ssh-keys
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/github.com

[linux]
add-packages: 
    _add-packages
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

[linux]
add-ssh-keys: _add-ssh-keys

