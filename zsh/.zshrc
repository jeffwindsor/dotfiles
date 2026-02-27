#!/usr/bin/env zsh

ZSH_CONFIG_DIR="${XDG_CONFIG_HOME}/zsh/"

# Load all modules in numbered order
for module in "${ZSH_CONFIG_DIR}"/*.zsh; do
  [[ -f "$module" ]] && source "$module"
done


export MAVEN_OPTS="-Xss3m -XX:ReservedCodeCacheSize=256m"
export SBT_OPTS='-Xms2G -Xmx2G'
export JAVA_OPTS='-Xms4G -Xmx4G -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=2096M'
export RESIN_HOME=$HOME/.local/bin/resin-4.0.66

MAIN=$SOURCE/gitlab.cj.dev/cjdev/main
BUILD_SCRIPTS=$MAIN/bin/build/maven
RESIN_SCRIPTS=$MAIN/bin/resin
RESIN_BIN=$RESIN_HOME/bin
PATH="$BUILD_SCRIPTS:$RESIN_SCRIPTS:$RESIN_BIN:$PATH"

