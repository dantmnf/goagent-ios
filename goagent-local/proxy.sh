#!/bin/sh
#
# control script for goagent-local
#
DBGLOG=/var/mobile/goagent/goagent.log
GOAGENT_PID=/var/mobile/goagent/goagent.pid
LAUNCHD_PLIST=org.goagent.local.ios.plist
start() {
    touch "$GOAGENT_PID"
}

run() {
    echo $$ > "$GOAGENT_PID"
    exec /Applications/goagent-ios.app/python/bin/python /Applications/goagent-ios.app/goagent-local/proxy.py
}

stop() {
    python_pid=$(cat "$GOAGENT_PID")
    rm -rf "$GOAGENT_PID"
    kill -9 $python_pid || killall python > /dev/null 2>/dev/null
}
# See how we were called.
case "$1" in
    start)
        start
        ;;
    run)
        run
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac
exit $?

