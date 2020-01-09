#!/bin/bash

# This will almost certainly be done via a chronjob.
# Do we want to stagger this so a lot of nodes are not doing it all at the same time?

# Once a month, perform the following maintenance:
# reboot?
# nfd restart? (At least this, if not a full reboot)

# Once a week, perform the following maintenance:
# apt-get autoremove; apt-get update; apt-get upgrade; apt-get autoremove

LOGDIR="/home/ndnops/tmp"
mkdir -p $LOGDIR
chown ndnops.ndnops $LOGDIR
chmod 755 $LOGDIR

DATE=`date +%Y.%B.%d.%H.%M.%S`
LOGFILE="$LOGDIR/monthlyNdnMaintenance.${DATE}.log"

date >& $LOGFILE
/usr/sbin/service nfd restart >> $LOGFILE


