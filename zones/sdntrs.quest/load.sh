#!/bin/sh

if [ $LOAD_ROUTER ]; then 
    /usr/sbin/ip route add 10.4.20.0/24 via "${LAB_IP}"
fi
