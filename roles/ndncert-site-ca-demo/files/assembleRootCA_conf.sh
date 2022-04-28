#!/bin/bash

if [ $# -ne 1 ]
then
  echo "Usage: $0 <root CS conf filename>"
  exit 1
fi
ROOT_CA_FILE=$1

FILES=`ls redirect_*_clause.txt`
echo "found $FILES"

cat root.ca.conf.head > $ROOT_CA_FILE

FIRST=1
for f in $FILES
do
  if [ $FIRST -ne 1 ]
  then 
    echo "," >> $ROOT_CA_FILE
  else
    FIRST=0
  fi
  echo "adding $f to file"
  cat $f >> $ROOT_CA_FILE
done
cat root.ca.conf.tail >> $ROOT_CA_FILE
