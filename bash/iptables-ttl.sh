#!/bin/bash

# TTL shift

set -xe

# iptables --ttl-inc 1
ssh 192.168.11.1 -l root iptables -t mangle -A PREROUTING -i ovpnclient -j TTL --ttl-inc 1
