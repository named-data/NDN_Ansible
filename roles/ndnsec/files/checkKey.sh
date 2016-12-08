#!/bin/bash

# ndnsec get-default
# ndnsec get-default -c
# ndnsec get-default -k

if [ $# -ne 1 ]
then
  echo "Usage: $0 <ndn name>"
  echo "Example: $0 /ndn/edu/wustl"
  exit 1
else
  NDN_NAME=$1
fi

DEF_KEY=`sudo su - ndnsec -c "ndnsec get-default -k 2> /dev/null"`
if [ $? -ne 0 ]
then
  echo "failed to get default key"
  exit 1
fi

exit 0
