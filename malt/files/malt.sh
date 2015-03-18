#!/usr/bin/env bash

LOG_DIR="/var/log/malt"
PID="/tmp/malt.pid"
MALT_HEAP_SIZE=30g
JVM_OPTS="$JVM_OPTS -Xmx$MALT_HEAP_SIZE -Dlogback.configurationFile=resources/logback.production.xml"

export ENVIRON=$MALT_MODE

case "$1" in
  start)
		if [ -f ${PID} ]
		then
			echo "Old PID file exists! " ${PID}
		else
			echo "Starting malt"
            mkdir -p ${LOG_DIR}
			cd /home/malt_deploy/malt

            export STORAGE_NODES=localhost
            export STORAGE_KEYSPACE=malt
            export CONFIGURATION_TABLE=configuration
            export APP_ENV=production
			nohup java -jar target/malt-standalone.jar >> /var/log/malt/malt.out 2>&1 & echo $! > ${PID}
		fi
    ;;
  stop)
    echo "Stopping malt"
	kill $(cat ${PID}) || true
	rm ${PID}
    ;;
  restart)
		./${0} stop
		./${0} start
		;;
	*)
    echo "Usage: /etc/init.d/malt {start|stop|restart|help}"
    exit 1
    ;;
esac

exit 0
