#!/bin/bash

export LC_ALL=C
# set TZ to UTC 0
export TZ=UTC0

dpkg -l | grep "nfd\ \|ndn-tools\|nlsr\|libndn-cxx\ \|libchronosync" > /usr/share/ndn/versions.txt
lsb_release -a | grep Description >> /usr/share/ndn/versions.txt

echo -n "Current Time: " >> /usr/share/ndn/versions.txt
CURRENT_TIME=`date +%s `
echo $CURRENT_TIME >> /usr/share/ndn/versions.txt

echo -n "NLSR start time:"  >> /usr/share/ndn/versions.txt
#ps -eo pid,lstart,cmd | grep nlsr | grep -v grep >> /usr/share/ndn/versions.txt
NLSR_START_TIME=`ps -eo pid,lstart,cmd | grep nlsr | grep -v gdb |grep -v grep >> /usr/share/ndn/versions.txt`
if [ -z "$NLSR_START_TIME" ]
then
  echo "NLSR_START_TIME: $CURRENT_TIME" >> /usr/share/ndn/versions.txt
else
  echo "NLSR_START_TIME: $NLSR_START_TIME" >> /usr/share/ndn/versions.txt
fi
#echo -n "Current Time: " >> /usr/share/ndn/versions.txt
#date +%s.%N >> /usr/share/ndn/versions.txt


NLSR_START_TIME=`echo $NLSR_START_TIME_STRING | awk '{print $3 " " $4 " " $5 " " $6}'`
#echo "NLSR_START_TIME: $NLSR_START_TIME" >> /usr/share/ndn/versions.txt

#NLSR_START_TIME_s=`date -d"$NLSR_START_TIME" +%s`
#echo "NLSR_START_TIME_s: $NLSR_START_TIME_s" >> /usr/share/ndn/versions.txt

UTC0_CURRENT_TIME=`date`
UTC0_NLSR_START_TIME=`ps -eo pid,lstart,cmd | grep nlsr | grep -v vi | grep -v tail | grep -v gdb | grep -v grep | awk '{print $2 " " $3 " " $4 " " $5 " UTC " $6}'`
echo "UTC0_CURRENT_TIME: $UTC0_CURRENT_TIME" >> /usr/share/ndn/versions.txt
if [ -z "$UTC0_NLSR_START_TIME" ]
then
  echo "empty" >> /usr/share/ndn/versions.txt
  UTC0_NLSR_START_TIME=$UTC0_CURRENT_TIME
  echo "UTC0_NLSR_START_TIME: $UTC0_CURRENT_TIME" >> /usr/share/ndn/versions.txt
else
  echo "UTC0_NLSR_START_TIME: $UTC0_NLSR_START_TIME" >> /usr/share/ndn/versions.txt
fi
NLSR_START_TIME_s=`date -d"$UTC0_NLSR_START_TIME" +%s`
echo "NLSR_START_TIME_s: $NLSR_START_TIME_s" >> /usr/share/ndn/versions.txt

#CERTBOT=`which certbot-auto`
CERTBOT="/usr/local/bin/certbot-auto"

if [ -n "$CERTBOT" -a -x $CERTBOT ]
then
  CERT_EXPIRY=`$CERTBOT  certificates 2> /dev/null | grep Expiry | awk '{print $3}'`
  if [ -z "$CERT_EXPIRY" ]
  then
    CERT_EXPIRY="no_cert"
  fi
else
  CERT_EXPIRY="no_cert"
fi
echo "TLS_CERT_Expires: $CERT_EXPIRY" >> /usr/share/ndn/versions.txt
