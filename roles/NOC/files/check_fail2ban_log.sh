#!/bin/bash

ADDRESSES=`sudo grep Ban /var/log/fail2ban.log | awk '{print $7}' | sort | uniq`

for a in $ADDRESSES
do
  echo -n "$a banned # times: "
  sudo grep $a /var/log/fail2ban.log | grep Ban | wc -l
done

