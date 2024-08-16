#!/bin/bash

# tcpdump to wireshark

set -xe

if [[ $# -eq 0 ]]; then
  ssh 192.168.11.1 -l root tcpdump -i any -w - | $(which wireshark) -k -i -
else
  ssh 192.168.11.1 -l root tcpdump "$@" -w - | $(which wireshark) -k -i -
fi
