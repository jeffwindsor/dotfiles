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

installcask() {
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
read -r -p "Add Homebrew? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    xcode-select --install
    
    # homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap homebrew/cask 
    brew tap homebrew/core 
    brew tap homebrew/fonts
    brew tap mas-cli/tap
fi 

##########################################################
read -r -p "Add Standard Packages? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            

    install bat
    install exa
    install fd
    install fzf
    install git
    install mas
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

    installcask alacritty
    installcask alfred
    installcask amethyst
    installcask caffeine
    installcask dash
    installcask emacs
    installcask firefox
    installcask font-cascadia
    installcask font-fira-code
    installcask font-inconsolata
    installcask font-jetbrains-mono
    installcask font-source-code-pro
    installcask gpg-suite
    installcask intellij-idea
    installcask slack
    installcask spotify
    installcask transmission
    installcask vlc
    installcask vscodium

    ################################################################
    echo "==> GIT REPOS INTO HOME ${HOME}/SRC"
    mkdir -p ${HOME}/src/hub

    cd $HOME/src
    clone-if-missing jeffwindsor dwm
    clone-if-missing jeffwindsor dwmblocks
    clone-if-missing jeffwindsor dmenu
    
    cd $HOME/src/hub

    ################################################################
    echo "==> STARSHIP PROMPT"
    curl -fsSL https://starship.rs/install.sh | bash -s -- --yes
    
    ################################################################
    echo "==> NVIM PLUGINS"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim --headless +PlugInstall +qall

    ################################################################
    echo "==> DOOM EMACS"
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
fi

##########################################################
read -r -p "Development Languages? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    
    #install ats2-postiats
    #install gcc
    install ghc
    install golang
    #install haskell-stack
    #install hlint
    #install idris
    install nodejs

    ################################################################
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
#read -r -p "Install Apple Store Applications? [y/n] " response
#response=${response,,}    # tolower
#if [[ "$response" =~ ^(yes|y)$ ]]
#then            
#    # mac apps
#    mas "LastPass", id: 926036361
#    mas "Microsoft Remote Desktop", id: 1295203466
#    mas "Be Focused - Focus Timer", id: 973134470
#    mas "iStat Menus", id: 1319778037
#    mas "Microsoft OneNote", id:784801555
#fi

##########################################################
read -r -p "Create SSH key? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    ssh-keygen -t rsa -b 4096 -C "jeff.windsor@gmail.com"
fi 

##########################################################
read -r -p "Add key to SSH Agent? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
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
read -r -p "Add CJ specific packages? [y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then            
    brew tap InstantClientTap/instantclient

    install cassandra
    install clojure
    install kafka
    install maven
    install maven-completion
    install openjdk
    #install parquet-tools
    install sbt
    install scala
    install selenium-server-standalone
    install jq
    install aws-cdk
    install awscli
    install awscli@1
    install openjdk@11

    installcask instantclient-basic
    installcask instantclient-sqlplus
    installcask java8
    installcask keybase
    installcask microsoft-teams

fi

open http://www.packal.org/workflow/colors
open http://www.packal.org/workflow/github-repos
open https://www.alfredapp.com/blog/productivity/dash-quicker-api-documentation-search/
