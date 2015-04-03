#!/bin/sh
### BEGIN INIT INFO
# Provides:
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start daemon at boot time
# Description:       Enable service provided by daemon.
### END INIT INFO

HEAP_SIZE='{{malt_engine_heap_size}}'
JVM_OPTS="$JVM_OPTS -Xmx$HEAP_SIZE -Dlogback.configurationFile=resources/logback.production.xml"
dir="/home/malt_deploy/malt_engine"
user="malt_deploy"
cmd="java ${JVM_OPTS} -jar target/malt-standalone.jar"

name=`basename $0`
pid_file="/var/run/malt_engine.pid"
stdout_log="/var/log/malt_engine/malt_engine.out"
stderr_log="/var/log/malt_engine/malt_engine.err"

get_pid() {
    cat "$pid_file"
}

is_running() {
    [ -f "$pid_file" ] && ps `get_pid` > /dev/null 2>&1
}

case "$1" in
    start)
    if is_running; then
        echo "Already started"
    else
        echo "Starting $name"
        mkdir -p $(dirname $stdout_log)
        cd "$dir"

        export STORAGE_NODES='{{cassandra_hosts}}'
        export STORAGE_KEYSPACE=malt
        export STORAGE_USER=malt
        export STORAGE_PASSWORD='{{cassandra_password}}'
        export CONFIGURATION_TABLE=configuration
        export APP_ENV=production

        ${cmd} >> "$stdout_log" 2>> "$stderr_log" &
        echo $! > "$pid_file"
        if ! is_running; then
            echo "Unable to start, see $stdout_log and $stderr_log"
            exit 1
        fi
    fi
    ;;
    stop)
    if is_running; then
        echo -n "Stopping $name.."
        kill `get_pid`
        for i in {1..10}
        do
            if ! is_running; then
                break
            fi

            echo -n "."
            sleep 1
        done
        echo

        if is_running; then
            echo "Not stopped; may still be shutting down or shutdown may have failed"
            exit 1
        else
            echo "Stopped"
            if [ -f "$pid_file" ]; then
                rm "$pid_file"
            fi
        fi
    else
        echo "Not running"
    fi
    ;;
    restart)
    $0 stop
    if is_running; then
        echo "Unable to stop, will not attempt to start"
        exit 1
    fi
    $0 start
    ;;
    status)
    if is_running; then
        echo "Running"
    else
        echo "Stopped"
        exit 1
    fi
    ;;
    *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
    ;;
esac

exit 0
