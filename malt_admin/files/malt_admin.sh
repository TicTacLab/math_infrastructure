#!/usr/bin/env bash

LOG_DIR="/var/log/malt_admin"
PID="/tmp/malt_admin.pid"
MALT_HEAP_SIZE=1g
JVM_OPTS="$JVM_OPTS -Xmx$MALT_HEAP_SIZE -Dlogback.configurationFile=resources/logback.production.xml"

export ENVIRON=$MALT_MODE

case "$1" in
  start)
		if [ -f ${PID} ]
		then
			echo "Old PID file exists! " ${PID}
		else
			echo "Starting malt_admin"
            mkdir -p ${LOG_DIR}
			cd /home/malt_deploy/malt_admin

            export WEB_HOST=0.0.0.0
            export WEB_PORT=80
            export STORAGE_NODES=localhost
            export STORAGE_KEYSPACE=malt
            export CONFIGURATION_TABLE=configuration
            export SETTINGS_TABLE=settings
            export APP_ENV=production
			nohup java ${JVM_OPTS} -jar target/malt-admin-standalone.jar >> /var/log/malt_admin/malt_admin.out 2>&1 & echo $! > ${PID}
		fi
    ;;
  stop)
    echo "Stopping malt_admin"
	kill $(cat ${PID}) || true
	rm ${PID}
    ;;
  restart)
		./${0} stop
		./${0} start
		;;
	*)
    echo "Usage: service malt_admin {start|stop|restart|help}"
    exit 1
    ;;
esac

exit 0
