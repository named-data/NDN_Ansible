#!/bin/bash

REPO_FACE=`nfdc fib list | grep repo | grep localhost | grep -v repo-ng-2 | cut -d '=' -f 3 | cut -d ' ' -f 1`
#echo "REPO_FACE=$REPO_FACE"
if [ -z "$REPO_FACE" ]
then
  #echo "No repo-ng running right now. exit..."
  exit 0
fi

names=`repo-ng-ls 2> /dev/null`
for name in $names
do
  NAME=`python -c "import pyndn as ndn; print(ndn.Name('$name').getPrefix(-3));"`
  X=`nfdc fib | grep $NAME`
  if [[ $X == "" ]]
  then
    RES="NOT PRESENT"
    #echo "NAME: $NAME"
    #echo "NOT PRESENT"
    nfdc route add $NAME $REPO_FACE
  else
    RES="ok"
    #echo "NAME: $NAME"
    #echo "ok"
  fi
  #echo "$NAME = $RES"
done

