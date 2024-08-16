#!/bin/bash

# TTL shift

set -xe

ssh 192.168.11.1 -l root iptables-save
