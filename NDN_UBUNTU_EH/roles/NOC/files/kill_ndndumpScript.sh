#!/bin/bash


SERVER_PID=`ps auxwww | grep ndndumpScript.sh | grep -v grep | grep -v checkAnd | awk '{print $2}'`

#echo "SERVER_PID=$SERVER_PID"
DATE=`date +%Y.%B.%d.%H.%M.%S`
#LOGFILE=ndnmapDataCollectorServer.$DATE
#LOGFILE=/dev/null
#HOSTNAME=`hostname`

sudo killall ndndump
if [ -z "$SERVER_PID" ]
then
    echo "no script running"
else
    sudo kill $SERVER_PID
fi

