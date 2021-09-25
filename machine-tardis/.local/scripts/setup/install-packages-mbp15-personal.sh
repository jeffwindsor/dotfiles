#!/usr/bin/env bash
cd "$(dirname "${0}")"

##########################################################
install() {
	if brew list $1 &> /dev/null; then
  		echo "==> "$1" [installed]"
	else
    	echo "==> "$1
    	brew install $1
    fi
}

install_cask() {
	if brew list --cask $1 &> /dev/null; then
  		echo "==> "$1" [installed]"
	else
    	echo "==> "$1
    	brew install --cask $1
    fi
}

clone-if-missing(){
    [[ ! -d $2 ]] && git clone https://github.com/${1}/${2}.git $2
}

##########################################################
read -r -p "Create SSH key? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    ssh-keygen -t rsa -b 4096 -C "jeff.windsor@gmail.com"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
fi 

##########################################################
read -r -p "Set zsh as default? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    sudo cat > /etc/shells <<EOL
/bin/sh
/usr/local/bin/bash
/usr/local/bin/fish
/usr/local/bin/zsh
EOL

    # set default shell
    chsh -s "$(which zsh)"
fi 

##########################################################
read -r -p "Add Homebrew? [y/n] " response
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    xcode-select --install
    
    # homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
    brew tap homebrew/core
    brew tap homebrew/cask
    brew tap homebrew/cask-fonts 
    brew tap homebrew/services
    brew tap railwaycat/emacsmacport
    #brew tap mas-cli/tap

    # apple store integration
    install mas
fi 

##########################################################
install bat
install exa
install fd
install fzf
install git
install koekeishiya/formulae/skhd  && brew services start skhd
install koekeishiya/formulae/yabai && brew services start yabai
install neovim
install ripgrep
install starship
install tldr
install topgrade
install zsh
install zsh-autosuggestions
install zsh-completions
install zsh-history-substring-search
install zsh-syntax-highlighting

install_cask alacritty
install_cask alfred
install_cask firefox
install_cask font-fira-code-nerd-font
install_cask font-hack-nerd-font
install_cask font-jetbrains-mono-nerd-font
install_cask keepingyouawake
install_cask slack
install_cask spotify

################################################################
cho "==> GIT REPOS INTO HOME ${HOME}/SRC"
mkdir -p ${HOME}/src/hub

cd $HOME/src
clone-if-missing jeffwindsor dwm
clone-if-missing jeffwindsor dwmblocks
clone-if-missing jeffwindsor dmenu
clone-if-missing jeffwindsor startpage
clone-if-missing jeffwindsor learn

################################################################
echo "==> NVIM PLUGINS"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim --headless +PlugInstall +qall

##########################################################
read -r -p "Development Languages? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    #install gnu-apl
    #install ats2-postiats
    #install gcc
    install golang
    install idris
    install nodejs

    ###############################################################
    echo "==> HASKELL"
    install ghc
    curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
    install hlint
    install haskell-stack

    ###############################################################
    echo "==> RUST LANG"
    curl --proto '=https' --tlsv1.2 -sSfo rustup-init.sh https://sh.rustup.rs
    chmod +x rustup-init.sh
    ./rustup-init.sh -y
    rm -f rustup-init.sh
    source $HOME/.cargo/env
    install cargo-completions
    cargo install cargo-update
fi

##########################################################
read -r -p "Install Apple Store Applications? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    # mac apps
    mas "LastPass", id: 926036361
    mas "Microsoft Remote Desktop", id: 1295203466
    mas "Be Focused - Focus Timer", id: 973134470
    mas "iStat Menus", id: 1319778037
    mas "Microsoft OneNote", id:784801555
fi

