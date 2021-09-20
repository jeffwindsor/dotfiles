#!/usr/bin/env bash
################################################################################
# POP-OS
################################################################################
cd "$(dirname "${0}")"

install() {
    if [ $(dpkg-query -W -f='${Status}' $1 | grep -c "ok installed") -eq 0 ];
    then
        printf "\033[0;32m==> installing $1 \033[0m \n"
        sudo apt-get -y install $1;
    else
        printf "\033[0;32m==> $1 \033[0m [installed] \n"
    fi
}
clone-if-missing(){
    [[ ! -d $2 ]] && git clone https://github.com/${1}/${2}.git $2
}

################################################################################
sudo apt update 
sudo apt upgrade
sudo apt autoremove

## SSH KEY 
read -p "Add SSH Key? " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    #echo "==> SSH"
    ssh-keygen -t ed25519 -C "jeff.windsor@gmail.com"
    eval $(ssh-agent)
    ssh-add ~/.ssh/id_ed25519
fi

# common directories
mkdir -p ${HOME}/src/hub
mkdir -p $HOME/.themes 
mkdir -p $HOME/.icons 

# Software
install alacritty
install bat
install exa
install fd-find
sudo cp /usr/bin/fdfind /usr/bin/fd
install fzf
install gnome-tweaks
install neovim
install ripgrep
install tldr
install zsh 
install zsh-autosuggestions 
install zsh-syntax-highlighting

echo "==> STARSHIP PROMPT"
curl -fsSL https://starship.rs/install.sh | bash -s -- --yes

echo "==> NVIM PLUGINS"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qall

echo "==> RUST"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# zsh as default shell
echo "==> ZSH as DEFAULT shell"
chsh -s "$(which zsh)"

################################################################################
echo "==> Manual steps"
xdg-open https://github.com/settings/keys
xdg-open https://mega.nz/sync
#xdg-open https://extensions.gnome.org/extension/600/launch-new-instance/
#xdg-open https://extensions.gnome.org/extension/1488/gnome-fuzzy-search/
xdg-open https://extensions.gnome.org/extension/906/sound-output-device-chooser/
xdg-open https://extensions.gnome.org/extension/21/workspace-indicator/
#xdg-open https://extensions.gnome.org/extension/19/user-themes/
#xdg-open https://extensions.gnome.org/extension/744/hide-activities-button/
#xdg-open https://www.gnome-look.org/p/1267246/
#xdg-open https://www.gnome-look.org/p/1357889/
#xdg-open https://www.gnome-look.org/s/Gnome/p/1166289 
xdg-open https://makedeb.hunterwittenborn.com/home/setup/

# MacbookPro Retina 15 Wifi: broadcom 14E4:43A0
#   https://unix.stackexchange.com/questions/175810/how-to-install-broadcom-bcm4360-on-debian-on-macbook-pro
#install broadcom-sta-dkms
#sudo modprobe -r b44 b43 b43legacy ssb brcmsmac
#sudo modprobe wl

# Laptop Power Management
#sysdl='/etc/systemd/logind.conf'
#cat $sysdl \
#    | sed -r 's/\#?HandleLidSwitchExternalPower=.*/HandleLidSwitchExternalPower=ignore/g' \
#    | sed -r 's/\#?HandleLidSwitch=.*/HandleLidSwitch=poweroff/g' \
#    | sudo tee $sysdl

