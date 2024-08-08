#!/bin/bash

# tcpdump to wireshark

set -xe

ssh 192.168.11.1 -l root tcpdump -i ovpnclient -w - "$@" | $(which wireshark) -k -i -
