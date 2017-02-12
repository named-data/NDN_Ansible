#!/bin/bash

# ndnsec get-default
# ndnsec get-default -c
# ndnsec get-default -k
#ndnsec-install-cert "http: ... "

sudo su - ndnsec -c "wget $1 -O cert.out"
sudo su - ndnsec -c "ndnsec-install-cert -f cert.out "

#sudo su - ndnsec -c "ndnsec-install-cert $1 "

sudo su - ndnsec -c "ndnsec-set-default -n $2"

sudo su - ndnsec -c "ndnsec-cert-dump -i $2 >& default.ndncert"

sudo cp ~ndnsec/default.ndncert /etc/ndn/keys



