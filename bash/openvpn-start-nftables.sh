#!/bin/bash

# enable nftables

date
echo $(dirname $0)/$(basename "$0")

#set -xe
cd "$(dirname $0)"


function start_nftables {
  echo -n "nftables :: start_nftables :: starting :: "
  systemctl start nftables
  systemctl status nftables | grep Active
  return $?
}


function interface_wlan0 {
  echo -n "interface :: interface_check :: interface_wlan0 :: checking :: "
  ip link show wlan0 | grep UP | grep -v DOWN
  return $?
}


function interface_ens3 {
  echo -n "interface :: interface_check :: interface_ens3  :: checking :: "
  ip link show ens3 | grep UP | grep -v DOWN
  return $?
}


function interface_check {
  echo "interface :: interface_check :: checking "
  if interface_wlan0; then
    echo "interface :: interface_check :: interface_wlan0 :: OK"
    return 0
  fi

  if interface_ens3; then
    echo "interface :: interface_check :: interface_ens3 :: OK"
    return 0
  fi

  return 1
}


while ! interface_check; do
  echo "interface :: interface_check :: FAIL"
  sleep 1
done

if interface_check; then
  echo "interface :: interface_check :: OK"
  if start_nftables; then
    echo "nftables :: start_nftables :: OK"
    exit 0
  fi
fi

exit 1
