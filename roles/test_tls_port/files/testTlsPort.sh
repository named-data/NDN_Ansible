#!/bin/bash

HOSTNAME=$1
SITENAME=$2

nc -z $HOSTNAME  443 >& /dev/null

if [ $?  -eq 0 ]
then
  # Success
  echo "$SITENAME has port 443 OPEN"
else
  # Failure
  echo "$SITENAME has port 443 CLOSED"
fi


