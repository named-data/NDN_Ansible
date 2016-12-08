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

DEF_CERT=`sudo su - ndnsec -c "ndnsec get-default -c 2> /dev/null"`
if [ $? -ne 0 ]
then
  echo "failed to get default cert"
  exit 1
fi

