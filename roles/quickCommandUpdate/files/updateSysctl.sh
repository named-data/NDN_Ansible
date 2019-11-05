#!/bin/bash

echo "net.ipv4.ipfrag_high_thresh=26214400" > /etc/sysctl.d/30-ipfrags.conf
echo "net.ipv4.ipfrag_time = 10" >> /etc/sysctl.d/30-ipfrags.conf

sysctl -p /etc/sysctl.d/30-ipfrags.conf


