#!/bin/bash

# enable nftables

date

set -xe
cd "$(dirname $0)"


function start_nftables {
  systemctl start nftables
  return $?
}


function interface_check {
  ip link show wlan0
  return $?
}


until interface_check; do
  echo "waiting for interface"
  sleep 1
done

start_nftables