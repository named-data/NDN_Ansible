#!/bin/bash

LOGFILE=/var/log/ndn/nfdc.face.list.log
touch $LOGFILE
echo " ------------------------------------" >> $LOGFILE
echo -n "DATE: " >>  $LOGFILE
date +%s.%N >>  $LOGFILE
echo "" >> $LOGFILE
ps alx | grep "nfd.conf\|PID" | grep -v grep >> $LOGFILE
echo "" >> $LOGFILE
nfdc face list >>  $LOGFILE 2>&1
echo " ------------------------------------" >> $LOGFILE

