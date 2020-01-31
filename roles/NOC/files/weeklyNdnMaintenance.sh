#!/bin/bash

# This will almost certainly be done via a cronjob.
# Do we want to stagger this so a lot of nodes are not doing it all at the same time?

# Once a month, perform the following maintenance:
# reboot?
# nfd restart? (At least this, if not a full reboot)

# Once a week, perform the following maintenance:
# apt-get autoremove; apt-get update; apt-get upgrade; apt-get autoremove

PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
LOGDIR="/home/ndnops/tmp"
mkdir -p $LOGDIR
chown ndnops.ndnops $LOGDIR
chmod 755 $LOGDIR

DATE=`date +%Y.%B.%d.%H.%M.%S`
LOGFILE="$LOGDIR/weeklyNdnMaintenance.${DATE}.log"

echo $DATE  >& $LOGFILE

echo "------ df------" >> $LOGFILE
df -h >> $LOGFILE
echo "------ apt-get -y autoremove ------" >> $LOGFILE
apt-get -y autoremove  >> $LOGFILE
echo "------ apt-get update ------" >> $LOGFILE
apt-get update >> $LOGFILE
echo "------ apt-get -y upgrade ------" >> $LOGFILE
apt-get -y upgrade >> $LOGFILE
echo "------ apt-get -y autoremove ------" >> $LOGFILE
apt-get -y autoremove >> $LOGFILE
echo "------ df------" >> $LOGFILE
df -h >> $LOGFILE
echo "------ done------" >> $LOGFILE
