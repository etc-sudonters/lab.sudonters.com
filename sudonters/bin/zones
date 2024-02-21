#!/bin/sh
set -eu

SUDONTERS=${SUDONTERS:-/etc/sudonters/}
SUDONTERS_RUN=${SUDONTERS_RUN:-"${SUDONTERS_RUN}"}

if [ $# != 1 ]; then 
    echo "expected exactly 1 argument: <path to zones>"
    exit 2
fi

rm -rf "${SUDONTERS_RUN}"/*.d || true

ZONE_BASE=${1%*/} # yank any trailing slash to normalize"

if [ ! -d "${ZONE_BASE}" ]; then
    echo "no zones to load"
    exit 0
fi

FEATURES=$(cat "$SUDONTERS/features.json")
echo "loaded features from ${SUDONTERS}/features.json"
echo "${FEATURES}"
LOAD=$(echo $FEATURES | jq '.load' -rM)
LOAD_DNS=false
LOAD_DHCP=false
LOAD_ROUTER=false
LAB_IP=$(echo $FEATURES | jq '.ip' -rM)

if echo $LOAD | grep 'dns' > /dev/null; then 
    LOAD_DNS=true
    mkdir -p "${SUDONTERS_RUN}"/dns.d
fi

if echo $LOAD | grep 'dhcp' > /dev/null; then 
    LOAD_DHCP=true
    mkdir -p "${SUDONTERS_RUN}"/dhcp.d
    touch "${SUDONTERS_RUN}"/dhcp.d/conf
fi

if echo $LOAD | grep 'router' > /dev/null; then 
    LOAD_ROUTER=true
fi

echo "LOAD_DNS: ${LOAD_DNS}"
echo "LOAD_DHCP: ${LOAD_DHCP}"
echo "LOAD_ROUTER: ${LOAD_ROUTER}"


for path in ${ZONE_BASE}/*/
do

    export fqzp=$(realpath ${path%*/})
    export zone=${fqzp##*/}

    echo "Processing ${zone}"

    if [ -f "${fqzp}/load.sh" ]; then 
        . "${fqzp}/load.sh"
    fi

    if [ $LOAD_DHCP = true ] && [ -f "${fqzp}/dhcpd.conf" ]; then 
        echo "Loading DHCP settings for ${zone}"
        ln -s "${fqzp}/dhcpd.conf" ""${SUDONTERS_RUN}"/dhcp.d/${zone}"
	echo "include \""${SUDONTERS_RUN}"/dhcp.d/${zone}\";" >> "${SUDONTERS_RUN}"/dhcp.d/conf
    fi

    if [ $LOAD_DNS = true ] && [ -f "${fqzp}/named.conf" ]; then
        echo "Loading DNS settings for ${zone}"
        "${SUDONTERS}"/gen-key.sh "${fqzp}" "${zone}" 
        ln -s "${fqzp}/named.conf" ""${SUDONTERS_RUN}"/dns.d/${zone}"
    fi
done

chmod -R a+wr /etc/sudonters/zones/
chmod -R a+wr "${SUDONTERS_RUN}"/*.d/
