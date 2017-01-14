#!/bin/bash


COUNT=5
THISNODE="WU"

if [ $# -ne 4 ]
then
      echo "Usage: $0 -c # -n <nodename>"
      echo "Example: $0 -c 500 -n WU         : to do a test with 500 ndnpings from node WU"
      exit
fi

while [ $# -ge 1 ]
do
  if [ $1 = "-c" ]
    then
      COUNT=$2
      shift
      shift
  elif [ $1 = "-n" ]
    then
      THISNODE=$2
      shift
      shift
    else
      echo "Usage: $0 [-q] [-c #] [-n <nodename>]"
      echo "Example: $0 -n WU         : to do a test with default settings from node WU"
      echo "Example: $0 -c 20         : to do an ndnping test with a ping count of 20"
      exit
  fi
done

DATE=`date -u +%Y_%m_%d_%H_%M_%S`
DATE_AND_TIME_UTC=`date -u`
mkdir -p TESTBED_DELAYS/$THISNODE


filename="full_prefix_list_UP.txt"
while read -a LINE ;
do
  NODENAME=${LINE[0]}
  PREFIX=${LINE[1]}
  LOGFILE="TESTBED_DELAYS/${THISNODE}/parallel_ndnping_from_${THISNODE}_to_${NODENAME}.$DATE"
  touch $LOGFILE
  echo "Testing delays with ndnping from node $THISNODE at $DATE_AND_TIME_UTC" >> $LOGFILE

  echo " ----------------------------------" >> $LOGFILE

  ndnping -t -c $COUNT $PREFIX >> ${LOGFILE} &

done < $filename
