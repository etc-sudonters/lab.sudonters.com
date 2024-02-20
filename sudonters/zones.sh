#!/bin/sh
set -eu

SUDONTERS=${SUDONTERS:-/etc/sudonters/}

if [ $# != 1 ]; then 
    echo "expected exactly 1 argument: <path to zones>"
    exit 2
fi

rm -rf /var/run/sudonters/*.d || true

ZONE_BASE=${1%*/} # yank any trailing slash to normalize"

if [ ! -d "${ZONE_BASE}" ]; then
    echo "no zones to load"
    exit 0
fi

FEATURES=$(cat "$SUDONTERS/features.json")
echo "loaded features from ${SUDONTERS}/features.json"
echo "${FEATURES}"
LOAD_DNS=false
LOAD_DHCP=false
LOAD_ROUTER=false
LAB_IP=$(echo $FEATURES | jq '.ip' -rM)

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

echo "LOAD_DNS: ${LOAD_DNS}"
echo "LOAD_DHCP: ${LOAD_DHCP}"
echo "LOAD_ROUTER: ${LOAD_ROUTER}"


for fqzp in ${ZONE_BASE}/*/
do
    echo "Attempting to load zone ${fqzp}"

    fqzp=${fqzp%*/}
    zone=${fqzp##*/}

    if [ -f "${fqzp}/load.sh" ]; then 
        . "${fqzp}/load.sh"
    fi

    if [ $LOAD_DHCP = true ] && [ -f "${fqzp}/dhcpd.conf" ]; then 
        echo "Loading DHCP settings for ${zone}"
        ln -s "${fqzp}/dhcpd.conf" "/var/run/sudonters/dhcp.d/${zone}"
    fi

    if [ $LOAD_DNS = true ] && [ -f "${fqzp}/named.conf" ]; then
        echo "Loading DNS settings for ${zone}"
        ln -s "${fqzp}/named.conf" "/var/run/sudonters/dns.d/${zone}"
    fi
done

