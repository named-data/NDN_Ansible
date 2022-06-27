#!/bin/bash

export LC_ALL=C
# set TZ to UTC 0
export TZ=UTC0

dpkg -l | grep "nfd\ \|ndn-tools\|nlsr\|libndn-cxx\ \|libchronosync\|libpsync" > /usr/share/ndn/versions.txt
lsb_release -a | grep Description >> /usr/share/ndn/versions.txt

echo -n "Current Time: " >> /usr/share/ndn/versions.txt
CURRENT_TIME=`date +%s `
echo $CURRENT_TIME >> /usr/share/ndn/versions.txt

echo -n "NLSR start time:"  >> /usr/share/ndn/versions.txt
NLSR_START_TIME=`ps -eo pid,lstart,cmd | grep nlsr | grep -v gdb |grep -v grep >> /usr/share/ndn/versions.txt`
if [ -z "$NLSR_START_TIME" ]
then
  echo "NLSR_START_TIME: $CURRENT_TIME" >> /usr/share/ndn/versions.txt
else
  echo "NLSR_START_TIME: $NLSR_START_TIME" >> /usr/share/ndn/versions.txt
fi

NLSR_START_TIME=`echo $NLSR_START_TIME_STRING | awk '{print $3 " " $4 " " $5 " " $6}'`

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

echo -n "NDNCERT_SiteCA start time:"  >> /usr/share/ndn/versions.txt
NDNCERT_SiteCA_START_TIME=`ps -eo pid,lstart,cmd | grep nlsr | grep -v gdb |grep -v grep >> /usr/share/ndn/versions.txt`
if [ -z "$NDNCERT_SiteCA_START_TIME" ]
then
  echo "NDNCERT_SiteCA_START_TIME: $CURRENT_TIME" >> /usr/share/ndn/versions.txt
else
  echo "NDNCERT_SiteCA_START_TIME: $NDNCERT_SiteCA_START_TIME" >> /usr/share/ndn/versions.txt
fi

NDNCERT_SiteCA_START_TIME=`echo $NDNCERT_SiteCA_START_TIME_STRING | awk '{print $3 " " $4 " " $5 " " $6}'`

UTC0_CURRENT_TIME=`date`
UTC0_NDNCERT_SiteCA_START_TIME=`ps -eo pid,lstart,cmd | grep nlsr | grep -v vi | grep -v tail | grep -v gdb | grep -v grep | awk '{print $2 " " $3 " " $4 " " $5 " UTC " $6}'`
echo "UTC0_CURRENT_TIME: $UTC0_CURRENT_TIME" >> /usr/share/ndn/versions.txt
if [ -z "$UTC0_NDNCERT_SiteCA_START_TIME" ]
then
  echo "empty" >> /usr/share/ndn/versions.txt
  UTC0_NDNCERT_SiteCA_START_TIME=$UTC0_CURRENT_TIME
  echo "UTC0_NDNCERT_SiteCA_START_TIME: $UTC0_CURRENT_TIME" >> /usr/share/ndn/versions.txt
else
  echo "UTC0_NDNCERT_SiteCA_START_TIME: $UTC0_NDNCERT_SiteCA_START_TIME" >> /usr/share/ndn/versions.txt
fi
NDNCERT_SiteCA_START_TIME_s=`date -d"$UTC0_NDNCERT_SiteCA_START_TIME" +%s`
echo "NDNCERT_SiteCA_START_TIME_s: $NDNCERT_SiteCA_START_TIME_s" >> /usr/share/ndn/versions.txt

SITE_CERT_EXPIRY_FULL=`ndnsec-cert-dump -p -f /etc/ndn/keys/default.ndncert | grep NotAfter | awk '{print $2}' | cut -c 1-8`
SITE_CERT_EXPIRY_YEAR=`echo $SITE_CERT_EXPIRY_FULL | cut -c 1-4`
SITE_CERT_EXPIRY_MONTH=`echo $SITE_CERT_EXPIRY_FULL | cut -c 5-6`
SITE_CERT_EXPIRY_DAY=`echo $SITE_CERT_EXPIRY_FULL | cut -c 7-8`
SITE_CERT_EXPIRY="${SITE_CERT_EXPIRY_YEAR}-${SITE_CERT_EXPIRY_MONTH}-${SITE_CERT_EXPIRY_DAY}"
echo "SITE_CERT_EXPIRES: $SITE_CERT_EXPIRY" >> /usr/share/ndn/versions.txt


#CERTBOT=`which certbot-auto`
#CERTBOT="/usr/local/bin/certbot-auto"
CERTBOT="/usr/bin/certbot"

if [ -n "$CERTBOT" -a -x $CERTBOT  ]
then
  XXX="ok"
else
  CERTBOT="/usr/bin/certbot"
fi
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
