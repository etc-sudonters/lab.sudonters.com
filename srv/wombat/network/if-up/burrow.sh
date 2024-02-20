#!/bin/sh

if [ "${IFACE}" == "enxb827eb017e41" ]; then
    /usr/sbin/iptables -A FORWARD -j ACCEPT 
    /usr/sbin/iptables -t nat -s 10.31.0.0/16 -A POSTROUTING -j MASQUERADE 
fi

