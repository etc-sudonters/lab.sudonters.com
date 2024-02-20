#!/bin/sh

if [ $LOAD_ROUTER = true ]; then 
    set -x
    /usr/sbin/ip route add 10.4.20.0/24 via "${LAB_IP}"
    set +x
fi
