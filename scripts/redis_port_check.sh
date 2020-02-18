#!/bin/bash +x

echo "We would check: ${1}:${2}"
echo "By command for test redis /usr/bin/redis-cli -h ${1} -p ${2} PING"
echo "But before we check tcp connection to target port ${2} of host ${1}"
echo "And if connectivity is available we'll check redis"
ALIVE=`timeout 2 /usr/bin/redis-cli -h ${1} -p ${2} PING`
LOGFILE="/var/log/keepalived/keepalived-redis-check.log"
pid=$$

STATUS=`timeout 2 bash -c "echo > /dev/tcp/${1}/${2}";  echo $?`
echo "Status of checking port: $STATUS"

# check exitcode of tcp connection yo ${1} port ${2}
if [ $STATUS == 0 ]; then
    # if $STATUS == 0, port is up and  we can test redis ping-pong
    echo "Port ${1}:${2} is open."
    # test redis connection by redis-cli PING and waiting get PONG
    if [ "$ALIVE" == "PONG" ]; then
        # if $ALIVE == PONG, it means that redis is up on remote host:port, exit code 0.
        echo "`date +'%Y-%m-%d %H:%M:%S'`|$pid|state:[check] Success: PING $ALIVE " >> $LOGFILE 2>&1
        echo "Checking redis ..."
        echo "`date +'%Y-%m-%d %H:%M:%S'`|$pid|state:[check] Success: PING $ALIVE " 
        exit 0
    else        
        echo "`date +'%Y-%m-%d %H:%M:%S'`|$pid|state:[check] Failed: PING $ALIVE " >> $LOGFILE 2>&1
        echo "Checking redis ..."
        echo "`date +'%Y-%m-%d %H:%M:%S'`|$pid|state:[check] Failed: PING $ALIVE " 
        # sleep 1
        exit 1
    fi
else
    echo "Port ${1}:${2} is closed."
    echo "Sorry, but port is down and we will not test redis connection."
    # sleep 1
    exit 1
fi
