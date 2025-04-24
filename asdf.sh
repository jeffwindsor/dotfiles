#!/usr/bin/env bash

# do this in home directory so .tool_version is used globally
cd

brew install asdf

echo " validate this exists or add it"
echo "export PATH='\${ASDF_DATA_DIR:-\$HOME/.asdf}/shims:\$PATH' >> .shellrc.local"

function add_asdf(){
  echo "==> adding $1 version $2"
  asdf plugin add "$1"
  asdf install "$1" "$2"
  asdf set "$1" "$2"
}

add_asdf java corretto-21.0.7.6.1
add_asdf maven 3.9.9
add_asdf scala 2.12.18
add_asdf nodejs 20.19.1
add_asdf awscli 2.27.0
add_asdf shellcheck 0.10.0

