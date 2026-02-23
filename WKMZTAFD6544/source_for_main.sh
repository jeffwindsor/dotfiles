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

if [[ condition ]]; then
  # https://nexus.cj.dev/repository/cj-software/cj/software/resin/4.0.66/resin-4.0.66.tar.gz
  # tar -xvzf resin-4.0.66.tar.gz
fi

# db setup - using remote "devdb"
source ~/Source/gitlab.cj.dev/cjdev/main/bin/build/devdb/devdb_includes.sh
devdb
export DEVDB_HOST=devdb.db.cj.com
export DEVDB_USERNAME=spud
export DEVDB_PORT=1521
export DEVDB_SID=devdb
