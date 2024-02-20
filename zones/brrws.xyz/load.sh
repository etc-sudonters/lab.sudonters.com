#!/bin/sh

if [ $LOAD_ROUTER ]; then 
    /usr/sbin/ip route add 10.60.22.0/24 via "${LAB_IP}"
fi
