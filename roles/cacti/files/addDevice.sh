#!/bin/bash

CACTI_DIR=/usr/share/cacti/
NAME=$1
HOSTNAME=$2
php -q $CACTI_DIR/cli/add_device.php --description="$NAME NDN Gateway" --ip=$HOSTNAME --avail=ping --ping_method=tcp --ping_port=22 --ping_retries=1 --timeout=1000 --version=0 --notes="$NAME NDN Testbed Gateway Node does not use SNMP"

