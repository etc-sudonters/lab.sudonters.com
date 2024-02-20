#!/bin/sh

if [ "${IFACE}" == "wlan0" ]; then
    /usr/sbin/iw wlan0 set power_save off
fi
