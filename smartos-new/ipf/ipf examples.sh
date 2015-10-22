#!/usr/bin/sh

## clear nat and firewall rules
[ -e /etc/ipf/ipnat.conf ] && rm /etc/ipf/ipnat.conf
[ -e /etc/ipf/ipf.conf ] && rm /etc/ipf/ipf.conf

## setup firewall
echo "# Default policies" >> /etc/ipf/ipf.conf
echo "pass out all keep state" >> /etc/ipf/ipf.conf
echo "block in all" >> /etc/ipf/ipf.conf
echo "block return-rst in log first proto tcp all" >> /etc/ipf/ipf.conf
echo "block return-icmp(host-unr) in log proto udp all" >> /etc/ipf/ipf.conf
echo "# Allow Loopback" >> /etc/ipf/ipf.conf
echo "pass in quick on lo0 all" >> /etc/ipf/ipf.conf
echo "pass out quick on lo0 all" >> /etc/ipf/ipf.conf
echo "# Allow ICMP" >> /etc/ipf/ipf.conf
echo "pass out quick proto icmp all keep state" >> /etc/ipf/ipf.conf
echo "pass in quick proto icmp all keep state" >> /etc/ipf/ipf.conf
echo "# Allow SSH" >> /etc/ipf/ipf.conf
echo "pass in quick proto tcp from any to any port = 22 flags S/FSRPAU keep state keep frags" >> /etc/ipf/ipf.conf

## setup portforwarding
echo "rdr e1000g0 from any to any port = 2201 -> 172.16.0.2 port 22 tcp" >> /etc/ipf/ipnat.conf
echo "pass in quick proto tcp from any to any port = 2201 flags S/FSRPAU keep state keep frags" >> /etc/ipf/ipf.conf
echo "rdr e1000g0 from any to any port = 2202 -> 172.16.0.3 port 22 tcp" >> /etc/ipf/ipnat.conf
echo "pass in quick proto tcp from any to any port = 2202 flags S/FSRPAU keep state keep frags" >> /etc/ipf/ipf.conf

## setup outbound nat
echo "map e1000g0 from 172.16.0.0/24 to any -> 0/32 proxy port ftp ftp/tcp" >> /etc/ipf/ipnat.conf
echo "map e1000g0 from 172.16.0.0/24 to any -> 0/32 portmap tcp/udp auto" >> /etc/ipf/ipnat.conf
echo "map e1000g0 from 172.16.0.0/24 to any -> 0/32" >> /etc/ipf/ipnat.conf
