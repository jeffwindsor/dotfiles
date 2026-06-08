dnf install bat lsd fd git neovim ripgrep stow zsh kitty

#dnf install lazygit mise starship television yazi

sudo dnf copr enable dejan/lazygit
sudo dnf install lazygit

dnf copr enable atim/starship
dnf install starship

curl -fsSL https://alexpasmantier.github.io/television/install.sh | bash

dnf copr enable lihaohong/yazi
dnf install yazi

curl https://mise.run | sh
