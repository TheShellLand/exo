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


function interface_wlan0 {
  echo "interface_wlan0 :: checking"
  ip link show wlan0
  ip link show wlan0 | grep UP
  return $?
}


function interface_ens3 {
  echo "interface_ens3 :: checking"
  ip link show ens3
  ip link show ens3 | grep UP
  return $?
}


function interface_check {
  echo "interface_check :: checking"
  if interface_wlan0; then
    echo "interface_wlan0 :: OK"
    return 0
  fi

  if interface_ens3; then
    echo "interface_ens3 :: OK"
    return 0
  fi

  return 1
}


while ! interface_check; do
  sleep 1
done

if interface_check; then
  echo "interface_check :: OK"
  if start_nftables; then
    echo "start_nftables :: OK"
    exit 0
  fi
fi

exit 1
