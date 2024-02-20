# raccoon 

10.31.0.2

DNS (bind9/named) and DHCP (isc-dhcp-server[^fn1]). These configuration files
go to their usual places -- `/etc/bind/` and `/etc/dhcp` -- in turn these load
their relevant configurations from their relevant `/var/run/sudonters/`
directory.

[^fn1]: EOL'd but for a quick setup internally, plus a good reason to lean kea
