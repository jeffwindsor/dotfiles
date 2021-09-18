#!/usr/bin/env zsh

####################################################################
# ZSH Config
####################################################################
# OPTIONS
export CLICOLOR=1
setopt LOCAL_OPTIONS EXTENDED_GLOB
setopt AUTO_MENU ALWAYS_TO_END AUTO_LIST NO_MENU_COMPLETE COMPLETE_IN_WORD NOMATCH
unsetopt FLOW_CONTROL
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
setopt NOTIFY
setopt PROMPT_SUBST
setopt MULTIOS CDABLE_VARS
unsetopt correctall BEEP

HISTSIZE=50000
SAVEHIST=10000

# auto/tab completion 
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)    #include hidden files

####################################################################
# MACOS SPECIFIC PLUGINS
####################################################################
source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZSH_PLUGINS/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###############################################################################
# PROMPT
###############################################################################
eval "$(starship init zsh)"

###############################################################################
# ALIASES & FUNCTIONS
###############################################################################

dot () { git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"; }
dot-add-all(){
    dot add -u
    dot add $XDG_CONFIG_HOME/_/*
}
dot-log-graph() { dot log --graph --pretty=format:${GIT_LOG_PRETTY_FORMAT} --abbrev-commit --max-count=${1:-10}; }
exec-on-git-repos () {
    local result=`git-find-dirs $2 | cut -d '/' -f5- | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden --reverse --height 40% | awk -v path="$2/" '{print path $0}'`
    [ ! -z "$result" ] && $1 $result
}
exec-on-file () {
    local result=`fd . "$2" -t f -H --ignore-file $XDG_CONFIG_HOME/fdignore | fzf`
    [ ! -z "$result" ] && $1 "$result"
}
git-to-main() { git branch -m master main && git push -u origin main; }
git-commit(){ git commit -m ${1:-'Refactor'}; }
git-log-graph(){ git log --graph --pretty=format:${GIT_LOG_PRETTY_FORMAT} --abbrev-commit --max-count=${1:-10}; }
git-find-dirs () { find $1 -type d \( -exec test -d "{}/.git" -a "{}" != "." \; -print -prune -o -name .git -prune \); }
stack-new(){ stack new $1 && cd $1 && stack setup && stack build; }
search-alias-functions(){
    echo '\e[1;34mNames\e[0m'
    print -l ${(ok)functions} | grep $1;
    echo '\e[1;34mAliases\e[0m'
    alias | grep $1;
}
sshkey(){ ssh-keygen -t ed25519 -C $1 -f $2; }
sshadd(){ eval "$(ssh-agent -s)" && ssh-add -K ~/.ssh/${1}; }

alias .....='cd ../../../../'
alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ..'
alias books='exec-on-file open $HOME/books/'
alias cat='bat -p'
alias cb='cabal build'
alias cg='cabal repl'
alias config='cd $XDG_CONFIG_HOME'
alias configs='nvim -c ":Files $XDG_CONFIG_HOME"'
alias cr='cabal -v0 run'
alias d='dirs -v | head -10'
alias da='dot add'
alias daa='dot-add-all'
alias dcm='dot commit -m'
alias ddiff='dot diff --ignore-space-at-eol -b -w --ignore-blank-lines'
alias dh='dot-log-graph'
alias dkl='docker ps -a'
alias dkr='docker run --rm'
alias dkrh='docker run --rm -d -p 8081:80'
alias dkrt='docker run --rm -it'
alias dl='dot ls-files'
alias doom="$HOME/.emacs.d/bin/doom"
alias dph='dot push'
alias dpl='dot pull'
alias dri='docker rmi -f $(docker images -a -q)'
alias ds='dot status -sb --ignore-submodules'
alias f='vifm'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch -v'
alias gc='git clone'
alias gcm='git-commit'
alias gco='git checkout'
alias gd='git diff --ignore-space-at-eol -b -w --ignore-blank-lines'
alias gh='git-log-graph'
alias gl='git log'
alias gph='git push'
alias gpl='git pull'
alias gr='git remote -vv'
alias grep='rg'
alias gs='git status -sb --ignore-submodules'
alias gsync='git checkout master && git pull --rebase && git checkout - && git rebase master'
alias k='clear'
alias kk='clear && reset'
alias ll='exa -lF --all --color=always --group-directories-first'       #alias ll='ls -laLhG'
alias lx='nnn -de'
alias rb='cargo build'
alias rc='cargo check'
alias repo='cd $HOME/src'
alias repos='exec-on-git-repos cd $SRC'
alias saf='search-alias-functions'
alias sb='stack build'
alias sc='stack clean'
alias sg='ghcid --command "stack repl" --test ":main"'
alias sinit='stack init'
alias sn='stack-new'
alias sr='stack repl'
alias src='cd $HOME/src'
alias srcs="exec-on-git-repos cd $SRC"
alias st='stack test'
alias stt='stack ide targets'
alias sup='stack upgrade --force-download'
alias theme="$HOME/.local/scripts/alacritty/change_theme"
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tree='exa --tree'
alias up='topgrade' # package upgrade
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias vv='nvim -O'
alias y='youtube-dl'
alias ya='youtube-dl --extract-audio --audio-format m4a --audio-quality 0'

###############################################################################
# MACOS
###############################################################################
brews() {
    local result=$(brew formulae | fzf -m --preview="brew info {}" --preview-window=:hidden --bind=space:toggle-preview)
    [ ! -z "$result" ] && brew install "$result"
}
casks() {
    local result=$(brew search --casks | fzf -m --preview="brew cask info {}" --preview-window=:hidden --bind=space:toggle-preview)
    [ ! -z "$result" ] && brew cask install "$result"
}
sha1-check()  { shasum -a 1 -c "$1.sha1"; }
sha256-check(){ shasum -a 256 -c "$1.sha256"; }
sha512-check(){ shasum -a 512 -c "$1.sha512"; }
md5-check()  { md5 -r "$1" | diff "$1.md5" -; }
alias aws1="alias aws='/usr/local/opt/awscli@1/bin/aws'"
alias aws2="unalias aws"
alias bc="brew cask"
alias bi="brew info"
alias bl="brew list && brew cask list && mas list"
alias bs="brew search"
alias bt="brew leaves | xargs brew deps --installed --for-each | sed \"s/^.*:/$(tput setaf 4)&$(tput sgr0)/\""
alias bundle_name="osascript -e 'id of app"
alias caskroom="cd /usr/local/Caskroom && l"
alias cellar="cd /usr/local/Cellar && l"
alias m5c="md5-check"
alias mf="mas info"
alias mi="mas install"
alias ml="mas list"
alias mr="mas uninstall"
alias ms="mas search"
alias mup="mas upgrade"
alias s1="shasum -a 1"
alias s1c="sha1-check"
alias s2="shasum -a 256"
alias s2c="sha256-check"
alias s5="shasum -a 512"
alias s5c="sha512-check"
alias uber='cd Library/Application\ Support/Übersicht/widgets/'

###############################################################################
# MACOS-CJ
###############################################################################
patch-update(){ ssh -t ${1} "sudo /usr/sbin/cnvr-patch update"; }
patch-query() { ssh -t ${1} "sudo /usr/sbin/cnvr-patch query"; }
alias acd="aws-cloudfront-describe"
alias acd="aws-cloudfront-describe-status"
alias dbstart="nohup VBoxHeadless --startvm 'Oracle11g32' &> /dev/null &"
alias dbstop="VBoxManage controlvm Oracle11g32 poweroff"
alias java11='export JAVA_HOME=`/usr/libexec/java_home -v 11`'
alias java15='export JAVA_HOME=`/usr/libexec/java_home -v 15`'
alias java8='export JAVA_HOME=`/usr/libexec/java_home -v 1.8.0_202`'
alias mc='k && java8 && mvn clean && java11'
alias mci='k && java8 && mvn clean install && java11'
alias qb='java8 && mvn clean install -T 1C -Ddelta.skip=true -Dcleanup.skip=true -Dqunit.numThreads=8 -DskipTests -Dtablespaces.skip=true -Dgulp.task=min && java11'
alias qqb='java8 && mvn install -T 1C -Ddelta.skip=true -Dcleanup.skip=true -Dqunit.numThreads=8 -DskipTests -Dtablespaces.skip=true -Dgulp.task=min && java11'
alias shopcart='sqlplus -L jwindsor@shopcart'
alias shuttle-init="$XDG_CONFIG_HOME/scripts/cj/shuttle-init"
alias t1='sqlplus -L cj@tcjoweb1'
alias test-schemas='java -jar ./target/schemas-main-SNAPSHOT.one-jar.jar locator=T5 tnsnames=/USers/jwindsor/.local/cjdev/ci/tns-admin/tnsnames.ora'
alias tns='v ~/.local/cjdev/ci/tns-admin/tnsnames.ora'
