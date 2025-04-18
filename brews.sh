#!/usr/bin/env bash

# bootstap brew
if ! command -v brew &> /dev/null; then
  /usr/bin/env bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

FORMULAE=(
  bash
  bat
  eza
  fd
  fzf
  git
  helix
  lazygit
  ripgrep
  sd
  starship
  stow
  television
  yazi
  zsh
)

CASK=(
  firefox
  ghostty
  google-chrome
  jordanbaird-ice  # bar icon manager
  keepingyouawake
  nikitabobko/tap/aerospace  #i3 like tiling
  zed
  zen-browser
)

# add machine specific packages
machine=$(networksetup -getcomputername)
echo "machine name: $machine"

if [[ $machine == "Midnight Air" ]]; then
  CASK=(
      "${CASK[@]}"
      balenaetcher     # usb iso app 
      chatgpt
      iina
      spotify
      transmission
    )
fi

if [[ $machine == "WKMZTAFD6544" ]]; then
  FORMULAE=(
    "${FORMULAE[@]}"
    maven
    colima
    lima
    docker
    docker-buildx
    lazydocker
  )
  CASK=(
    "${CASK[@]}"
    intellij-idea
    slack
  )

fi

FORMULAE_INSTALLED=($(brew leaves | col))  # leaves only shows top level packages, list shows all installed including dependencies
FORMULAE_TO_INSTALL=($(comm -23 <(printf "%s\n" "${FORMULAE[@]}" | sort -u) <(printf "%s\n" "${FORMULAE_INSTALLED[@]}" | sort -u)))
FORMULAE_TO_REMOVE=($(comm -23 <(printf "%s\n" "${FORMULAE_INSTALLED[@]}" | sort -u) <(printf "%s\n" "${FORMULAE[@]}" | sort -u)))

CASK_INSTALLED=($(brew list --cask --full-name | col))
CASK_TO_INSTALL=($(comm -23 <(printf "%s\n" "${CASK[@]}" | sort -u) <(printf "%s\n" "${CASK_INSTALLED[@]}" | sort -u)))
CASK_TO_REMOVE=($(comm -23 <(printf "%s\n" "${CASK_INSTALLED[@]}" | sort -u) <(printf "%s\n" "${CASK[@]}" | sort -u)))


function brew_command(){
  echo -e "\e[94m==> Brew Install $@ <==\e[0m"
  eval "brew $@"
}
echo "== MENU =="
echo "formulae: ${FORMULAE[@]}"
echo "cask: ${CASK[@]}"
echo "== TO INSTALL =="
echo "formulae: ${FORMULAE_TO_INSTALL[@]}"
echo "cask: ${CASK_TO_INSTALL[@]}"
echo "== TO REMOVE =="
echo "formulae: ${FORMULAE_TO_REMOVE[@]}"
echo "cask: ${CASK_TO_REMOVE[@]}"
echo "== BREWS =="
for f in "${FORMULAE_TO_INSTALL[@]}"; do brew_command "install --formulae $f"; done
for f in "${FORMULAE_TO_REMOVE[@]}"; do brew_command "remove --formulae $f"; done
for c in "${CASK_TO_INSTALL[@]}"; do brew_command "install --cask $c"; done
for c in "${CASK_TO_REMOVE[@]}"; do brew_command "remove --cask $c"; done
