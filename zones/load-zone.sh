#!/bin/sh

if [ $# != 2 ]; then 
    echo "expected exactly 2 argument: <path to zones> <lab ip>"
    exit 2
fi

ZONE_BASE=${1%*/} # yank any trailing slash to normalize"
LAB_IP=${2}

if [ ! -d "${ZONE_BASE}" ]; then
    echo "no zones to load"
    exit 0
fi

FEATURES=$(cat /opt/sudonters/zones/load.json)
LOAD_DNS=false
LOAD_DHCP=false
LOAD_ROUTER=false

if echo $FEATURES | grep 'dns' > /dev/null; then 
    LOAD_DNS=true
    mkdir -p /var/run/sudonters/dns.d
fi

if echo $FEATURES | grep 'dhcp' > /dev/null; then 
    LOAD_DHCP=true
    mkdir -p /var/run/sudonters/dhcp.d
fi

if echo $FEATURES | grep 'router' > /dev/null; then 
    LOAD_ROUTER=true
fi


for fqzp in "${ZONE_BASE}/*/"
do
    tmp=${fqzp%*/}
    zone=${tmp##*/}

    if [ -f "${fqzp}/load.sh" ]; then 
        "${fqzp}/load.sh"
    fi

    if [ $LOAD_DHCP ] && [ -f "${fqzp}/dhcpd.conf" ]; then 
        echo "Loading DHCP settings for ${zone}"
        ln -s "${fqzp}/dhcpd.conf" "/var/run/sudonters/dhcp.d/${zone}"
    fi

    if [ $LOAD_DNS ] && [ -f "${fqzp}/named.conf" ]; then
        echo "Loading DNS settings for ${zone}"
        ln -s "${fqzp}/named.conf" "/var/run/sudonters/dns.d/${zone}"
    fi
done

