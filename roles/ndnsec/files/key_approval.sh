#!/bin/bash


YEAR=`date +%Y`
MONTH=`date +%m`
DAY=`date +%d`
TIME="0000"
YEARPLUS1=$(($YEAR + 1))

START_TIME=${YEAR}${MONTH}${DAY}${TIME}
END_TIME=${YEARPLUS1}${MONTH}${DAY}${TIME}

# For each file /home/testbed-root/site-certs/*_unsigned_site.cert 
# produce a signed cert and put it in the file *.signed

UNSIGNED_CERTS=`ls /home/testbed-root/site-certs/`
for f in $UNSIGNED_CERTS
do
  cmd="cd /home/testbed-root/site-certs; ndnsec-cert-gen -S $START_TIME -E $END_TIME -s /ndn -r ${f}> ${f}.signed "
  echo "$cmd" > /tmp/cmd.txt
  sudo su - testbed-root -c "$cmd"
  #rm -f $f
done
