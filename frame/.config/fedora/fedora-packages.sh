dnf install bat lsd fd git neovim ripgrep stow zsh kitty

#### RPM PACKAGES ####

# brave browser
sudo dnf install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser

#### COPR PACKAGES ####

# lazygit
sudo dnf copr enable dejan/lazygit
sudo dnf install lazygit

# starship
dnf copr enable atim/starship
dnf install starship

dnf copr enable lihaohong/yazi
dnf install yazi

#### curl based packages ####

# television
curl -fsSL https://alexpasmantier.github.io/television/install.sh | bash

# tinty:
# https://github.com/tinted-theming/tinty/releases
