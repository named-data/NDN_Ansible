#!/bin/bash


SERVER_PID=`ps auxwww | grep ndndumpScript.sh | grep -v grep | grep -v checkAnd | awk '{print $2}'`

#echo "SERVER_PID=$SERVER_PID"
DATE=`date +%Y.%B.%d.%H.%M.%S`
#LOGFILE=ndnmapDataCollectorServer.$DATE
#LOGFILE=/dev/null
#HOSTNAME=`hostname`

if [ -z "$SERVER_PID" ]
then
    sudo killall ndndump
    #echo "LOGFILE=$LOGFILE"
    #cd /home/jdd/WU-ARL/ndnmap/nfdDataCollection
    #build/nfdstat_s -r 700 -t 1300 -n 90 -f linksList.testbed >& $LOGFILE &
    nohup /home/ndnops/ndn-ops/NOC/bin/ndndumpScript.sh &
else
    echo "SERVER_PID: $SERVER_PID"
fi

