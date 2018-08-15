#!/bin/bash

FILES=`ls roles/cert_operator_domain_db_gen/files/cert_operator_domain_db_dir/cert_operator_domain_db.*.txt`
first=false
#echo "FILES: $FILES"
cat roles/cert_operator_domain_db_gen/files/Root.entry
for f in $FILES
do
#  echo "f: $f"
  if [ $first = true ]
  then
    first=false
    echo "{"
  else
    echo ","
  fi
  cat $f

done
echo "}"

