#!/bin/bash


if [ $# -ne 1 ]
then
  echo "Usage: $0 <ndn name>"
  echo "Example: $0 /ndn/edu/wustl"
  exit 1
else
  NDN_NAME=$1
fi
BOTH=`sudo su - ndnsec -c "ndnsec cert-dump -i $NDN_NAME -p" | grep "Not"`
#echo "BOTH Dates: "
#echo "$BOTH"

START_DATE=`echo $BOTH | cut -d ':' -f 2 | cut -d ' ' -f 2`
END_DATE=`echo $BOTH | cut -d ':' -f 3 |cut  -c 2-100`
#echo "START_DATE=$START_DATE"
#echo "END_DATE=$END_DATE"

START_YEAR=`echo $START_DATE| cut -c 1-4`
END_YEAR=`echo $END_DATE| cut -c 1-4`
START_MONTH=`echo $START_DATE| cut -c 5-6`
END_MONTH=`echo $END_DATE| cut -c 5-6`
START_DAY=`echo $START_DATE| cut -c 7-8`
END_DAY=`echo $END_DATE| cut -c 7-8`
START_HOUR=`echo $START_DATE| cut -c 10-11`
END_HOUR=`echo $END_DATE| cut -c 10-11`
START_MIN=`echo $START_DATE| cut -c 12-13`
END_MIN=`echo $END_DATE| cut -c 12-13`
START_SEC=`echo $START_DATE| cut -c 14-15`
END_SEC=`echo $END_DATE| cut -c 14-15`

#echo "START_YEAR: $START_YEAR"
#echo "START_MONTH: $START_MONTH"
#echo "START_DAY: $START_DAY"
#echo "START_HOUR: $START_HOUR"
#echo "START_MIN: $START_MIN"
#echo "START_SEC: $START_SEC"
#echo "END_YEAR: $END_YEAR"
#echo "END_MONTH: $END_MONTH"
#echo "END_DAY: $END_DAY"
#echo "END_HOUR: $END_HOUR"
#echo "END_MIN: $END_MIN"
#echo "END_SEC: $END_SEC"

NOW=`date -u +%Y:%m:%d:%k:%M:%S`
#echo "NOW: $NOW"
NOW_YEAR=`echo $NOW|cut -d':' -f 1`
NOW_MONTH=`echo $NOW|cut -d':' -f 2`
NOW_DAY=`echo $NOW|cut -d':' -f 3`
NOW_HOUR=`echo $NOW|cut -d':' -f 4`
NOW_MIN=`echo $NOW|cut -d':' -f 5`
NOW_SEC=`echo $NOW|cut -d':' -f 6`

#echo "NOW_YEAR=$NOW_YEAR"
#echo "NOW_MONTH=$NOW_MONTH"
#echo "NOW_DAY=$NOW_DAY"
#echo "NOW_HOUR=$NOW_HOUR"
#echo "NOW_MIN=$NOW_MIN"
#echo "NOW_SEC=$NOW_SEC"

if [ $NOW_YEAR -ge $START_YEAR -a $NOW_YEAR -le $END_YEAR ]
then
  if [ $NOW_YEAR -lt $END_YEAR ]
  then
    #echo "Cert has valid time"
    exit  0
  fi
  if [ $NOW_MONTH -ge $START_MONTH -a $NOW_MONTH -le $END_MONTH ]
  then
    if [ $NOW_MONTH -lt $END_MONTH ]
    then
      #echo "Cert has valid time"
      exit 0
    fi
    if [ $NOW_DAY -ge $START_DAY -a $NOW_DAY -le $END_DAY ]
    then
      if [ $NOW_DAY -lt $END_DAY ]
      then
        #echo "Cert has valid time"
        exit 0
      fi
      if [ $NOW_HOUR -ge $START_HOUR -a $NOW_HOUR -le $END_HOUR ]
      then
        if [ $NOW_HOUR -lt $END_HOUR ]
        then
          # echo "Cert has valid time"
          exit 0
        fi
        if [ $NOW_MIN -ge $START_MIN -a $NOW_MIN -le $END_MIN ]
        then
          if [ $NOW_MIN -lt $END_MIN ]
          then
            #echo "Cert has valid time"
            exit 0
          fi
          if [ $NOW_SEC -ge $START_SEC -a $NOW_SEC -le $END_SEC ]
          then
            #echo "Cert has valid time"
            exit 0
          fi
        fi
      fi
    fi
  fi
fi
#echo "Cert has invalid time"
exit 1
  
  
