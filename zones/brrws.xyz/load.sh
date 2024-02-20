#!/bin/sh

if [ $LOAD_ROUTER = true ]; then 
    set -x
    /usr/sbin/ip route replace 10.60.22.0/24 via "${LAB_IP}"
    set +x
fi
