#!/bin/bash

# cat operator file > sitefile
# echo -n "cert:" >> sitefile
# tr -d '\n' WU.cert >> sitefile

#cert_operator_domain_db_dir/WU.cert				cert_operator_domain_db_dir/cert_operator_domain_db.WU.txt
#cert_operator_domain_db_dir/WU.cert.sed				cert_operator_domain_db_dir/operator_domain_db.WU.txt
#cert_operator_domain_db_dir/WU.cert.tr

SITE=$1
DIR=roles/cert_operator_domain_db_gen/files/cert_operator_domain_db_dir
SITEFILE=${DIR}/cert_operator_domain_db.${SITE}.txt
CERTFILE=${DIR}/${SITE}.cert
OPERATORFILE=${DIR}/operator_domain_db.${SITE}.txt

cat ${OPERATORFILE} > $SITEFILE
echo -n "\"cert\": \"" >> $SITEFILE
cat ${CERTFILE} | tr -d '\n' >> $SITEFILE
echo  "\"" >> $SITEFILE



