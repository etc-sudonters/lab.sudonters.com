#!/bin/sh

if [ "${IFACE}" == "enxb827eb017e41" ]; then
    /usr/sbin/iptables -A FORWARD -j ACCEPT 
    /usr/sbin/iptables -t nat -s 10.31.0.0/16 -A POSTROUTING -j MASQUERADE 
    /usr/sbin/ip route add 10.60.22.0/24 via 10.31.0.1
    /usr/sbin/ip route add 10.4.20.0/24 via 10.31.0.1
fi

