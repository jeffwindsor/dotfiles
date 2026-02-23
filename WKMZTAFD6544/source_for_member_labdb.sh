export MAVEN_OPTS="-Xss3m -XX:ReservedCodeCacheSize=256m"
export SBT_OPTS='-Xms2G -Xmx2G'
export JAVA_OPTS='-Xms4G -Xmx4G -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=2096M'
export RESIN_HOME=$HOME/bin/resin-4.0.66

# resin path config
MAIN=$SOURCE/gitlab.cj.dev/cjdev/main
BUILD_SCRIPTS=$MAIN/bin/build/maven
RESIN_SCRIPTS=$MAIN/bin/resin
RESIN_BIN=$RESIN_HOME/bin
PATH="$BUILD_SCRIPTS:$RESIN_SCRIPTS:$RESIN_BIN:$PATH"

~/Source/gitlab.cj.dev/cjdev/main/bin/resin/runResinMember lab105
