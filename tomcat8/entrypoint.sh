#!/bin/bash
set -e

if [ "$1" = 'startup.sh' ] || [ "$1" = 'catalina.sh' ]; then
    exec su-exec tomcat "$@"
fi

exec "$@"