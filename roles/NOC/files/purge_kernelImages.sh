#!/bin/bash

NAMES=`dpkg -l | grep linux-image  | grep ^rc | awk '{print $2}'`

#echo $NAMES


for n in $NAMES
do
   echo "sudo apt-get -y purge $n"
   sudo apt-get -y purge $n
done

