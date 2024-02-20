# burrow.lab.sudonters.com

Homelab setup.

* burrow.lab.sudonters.com -- physical network
* brrws.xyz -- publicly exposed services
* sdntrs.quest -- privately exposed services


Zones are loaded from `/opt/sudonters/zones`, from there configurations are
linked to:

* `<zone-name>/named.conf` -> `/var/run/sudonters/dns.d/<zone-name>-named.conf`
* `<zone-name>/dhcpd.conf` -> `/var/run/sudonters/dhcp.d/<zone-name>-dhcpd.conf`


