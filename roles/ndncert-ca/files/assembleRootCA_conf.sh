#!/bin/bash

DIR=roles/ndncert-ca/files/
ROOT_CA_FILE=${DIR}/rootCA.conf

FILES=`ls ${DIR}/redirect_*_clause.txt`
#echo "found $FILES"

cat ${DIR}/root.ca.conf.head > $ROOT_CA_FILE

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
cat ${DIR}/root.ca.conf.tail >> $ROOT_CA_FILE
