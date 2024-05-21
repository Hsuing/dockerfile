#!/bin/sh
cd /opt/${APP}
if [[ $# -lt 1 ]] || [[ "$1" == "--"* ]]; then
  JAVA_OPTS=" -server -Xmn256m -Xss256k -Djava.security.egd=file:/dev/./urandom -XX:MaxRAMPercentage=80.0 -XX:+UseContainerSupport -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 "
exec java ${JAVA_OPTS} -jar ${APP}.jar "$@"
fi
exec "$@"