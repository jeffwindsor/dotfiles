# install packages script
# execute under sudo

dnf install bat
dnf install lsd
dnf install fd
dnf install fzf
dnf install git
dnf install neovim
dnf install ripgrep
dnf install stow
dnf install yazi
dnf install zsh

# lazygit
dnf copr enable dejan/lazygit
dnf install lazygit

# mise

# starship
dnf copr enable atim/starship
dnf install starship

# television
# curl -fsSL https://alexpasmantier.github.io/television/install.sh | bash

# yazi
dnf copr enable lihaohong/yazi
dnf install yazi

# zellij
dnf copr enable varlad/zellij
dnf install zellij
