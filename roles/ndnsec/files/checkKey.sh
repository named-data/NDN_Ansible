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

DEF_NAME=`sudo su - ndnsec -c "ndnsec get-default 2> /dev/null"`
if [ $? -ne 0 ]
then
  echo "failed to get default name"
  exit 1
fi

if [ "$NDN_NAME" != "$DEF_NAME" ]
then
  echo "given name was not default name"
  exit 1
fi

DEF_KEY=`sudo su - ndnsec -c "ndnsec get-default -k 2> /dev/null"`
if [ $? -ne 0 ]
then
  echo "failed to get default key"
  exit 1
fi
DEF_CERT=`sudo su - ndnsec -c "ndnsec get-default -c 2> /dev/null"`
if [ $? -ne 0 ]
then
  echo "failed to get default cert"
  exit 1
fi

#echo "Default Name: $DEF_NAME"
#echo "Default  Key: $DEF_KEY"
#echo "Default Cert: $DEF_CERT"

./checkForValidCert.sh $DEF_NAME
if [ $? -eq 0 ]
then
  echo "Found cert with valid date"
else
  echo "Did NOT find cert with valid date"
fi
