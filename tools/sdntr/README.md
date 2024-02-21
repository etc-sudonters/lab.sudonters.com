# sdntr

manages shit on my servers so i don't have to

ensures that configurations for things like bind9 or ip route and iptable rules
don't get out of date and collect cruft or undocumented changes are made.

configurations for services like bind9 are generated into a temporary directory
and the unit file for the service modified before starting/restarting the
service

`ip table` and `ip route` changes attempt to be upserts where possible

## features

* configure via an awful yaml file![^fn1]
* break down homelab 
* auto reloading?
* chemicals known to cause cancer to the state of California


## zones

Subnets, routes, dns[^fn2], dhcp if you want it, even some kubernetes bullshit!



[^fn1]: toml nerds get stuffed into lockers, json nerds are cool but aren't in
  the group chat

[^fn2]: limited time offer: free rndc-key!
