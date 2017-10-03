#!/bin/bash

ADDRESSES=`sudo grep --binary-files=text Ban /var/log/fail2ban.log | awk '{print $7}' | sort | uniq`

for a in $ADDRESSES
do
  echo -n "$a banned # times: "
  sudo grep --binary-files=text $a /var/log/fail2ban.log | grep Ban | wc -l
done

