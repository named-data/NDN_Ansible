#!/bin/bash


YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
TIME="0000"
YEARPLUS1=$(($YEAR + 1))

START_TIME=${YEAR}${MONTH}${DAY}${TIME}
END_TIME=${YEARPLUS1}${MONTH}${DAY}${TIME}

# For each file /home/ndnsec/site-certs/REMAP*_unsigned_site.cert 
# produce a signed cert and put it in the file *.signed

UNSIGNED_CERTS=`ls /home/ndnsec/site-certs/`
for f in $UNSIGNED_CERTS
do
  cmd="cd /home/ndnsec/site-certs; ndnsec-cert-gen -S $START_TIME -E $END_TIME -s /ndn/edu/ucla -r ${f}> ${f}.signed "
  echo "$cmd" > /tmp/cmd.txt
  sudo su - ndnsec -c "$cmd"
  #rm -f $f
done
