#!/bin/bash
# default_prefix
PREFIX=$1
# ansible_user
OPERATOR=$2  
# inventory_hostname
HOSTNAME=$3
# router_name
ROUTER=$4

# point home to /var/lib/ndn/nlsr so keys will be stored there.
# seems that now we have to set a default identity:
sudo su - nlsr -c 'export HOME=/var/lib/ndn/nlsr/; ndnsec-set-default -n ${PREFIX}/nlsr'

sudo su - nlsr -c 'export HOME=/var/lib/ndn/nlsr/; ndnsec-key-gen -n ${PREFIX}/%C1.Operator/${OPERATOR} > ~nlsr/unsigned_operator.cert'
sudo su - nlsr -c 'export HOME=/var/lib/ndn/nlsr/; ndnsec-set-default -n ${PREFIX}/nlsr'
sudo su - nlsr -c 'export HOME=/var/lib/ndn/nlsr/; ndnsec-cert-gen -S 201507080000 -E 201810080000 -N "${HOSTNAME} Operator" -s ${PREFIX} -p ${PREFIX}/%C1.Operator/${OPERATOR} -r ~nlsr/unsigned_operator.cert > /etc/ndn/nlsr/keys/operator.cert'
sudo su - nlsr -c 'export HOME=/var/lib/ndn/nlsr/; ndnsec-key-gen -n ${PREFIX}/%C1.Router/${ROUTER} > ~nlsr/unsigned_router.cert'
sudo su - nlsr -c 'export HOME=/var/lib/ndn/nlsr/; ndnsec-cert-gen -S 201507080000 -E 201810080000 -N "${HOSTNAME} Router ${ROUTER}" -s ${PREFIX}/%C1.Operator/${OPERATOR} -p ${PREFIX}/%C1.Router/${ROUTER} -r ~nlsr/unsigned_router.cert > /etc/ndn/nlsr/keys/router.cert'
