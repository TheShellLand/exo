#!/bin/bash

# enable nftables

date

set -xe
cd "$(dirname $0)"


function start_nftables {
  echo "start_nftables :: starting"
  systemctl start nftables
  return $?
}


function interface_check {
  echo "interface_check :: checking"
  ip link show wlan0
  ip link show wlan0 | grep UP
  return $?
}


while ! interface_check; do
  sleep 1
done

if interface_check; then
  echo "interface_check :: OK"
  if start_nftables; then
    echo "start_nftables :: OK"
    exit $?
  fi
fi

exit 1
