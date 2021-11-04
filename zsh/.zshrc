#!/usr/bin/env zsh

for rc in $XDG_CONFIG_HOME/zsh/*
do
    source $rc
done


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jefwinds/.sdkman"
[[ -s "/Users/jefwinds/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jefwinds/.sdkman/bin/sdkman-init.sh"
