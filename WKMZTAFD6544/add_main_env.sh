# Usage: source add_main_env.sh devdb|intranet|member

export MAVEN_OPTS="-Xss3m -XX:ReservedCodeCacheSize=256m"
export SBT_OPTS='-Xms2G -Xmx2G'
export JAVA_OPTS='-Xms4G -Xmx4G -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=2096M'
export RESIN_HOME=$HOME/bin/resin-4.0.66

MAIN=$SOURCE/gitlab.cj.dev/cjdev/main
BUILD_SCRIPTS=$MAIN/bin/build/maven
RESIN_SCRIPTS=$MAIN/bin/resin
RESIN_BIN=$RESIN_HOME/bin
PATH="$BUILD_SCRIPTS:$RESIN_SCRIPTS:$RESIN_BIN:$PATH"

case "${1:-}" in
  devdb)
    source ~/Source/gitlab.cj.dev/cjdev/main/bin/build/devdb/devdb_includes.sh
    devdb
    export DEVDB_HOST=devdb.db.cj.com
    export DEVDB_USERNAME=spud
    export DEVDB_PORT=1521
    export DEVDB_SID=devdb
    ;;
  intranet)
    ~/Source/gitlab.cj.dev/cjdev/main/bin/resin/runResinIntranet lab105
    ;;
  member)
    ~/Source/gitlab.cj.dev/cjdev/main/bin/resin/runResinMember lab105
    ;;
  *)
    echo "Usage: source add_main_env.sh [devdb|intranet|member]" >&2
    return 1
    ;;
esac
