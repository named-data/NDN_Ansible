#!/bin/bash

# 1: cert url
# 2: default prefix

sudo su - ndnsec -c "ndnsec-install-cert -f /etc/ndn/keys/default.ndncert "

sudo su - ndnsec -c "ndnsec-set-default -n $2"

#sudo su - ndnsec -c "ndnsec-cert-dump -i $2 >& default.ndncert"

#sudo cp ~ndnsec/default.ndncert /etc/ndn/keys



