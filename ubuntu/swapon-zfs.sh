#!/bin/bash

# Make a swap file and mount it

zfs create -V 10G -b $(getconf PAGESIZE) -o compression=zle \
      -o logbias=throughput -o sync=always \
      -o primarycache=metadata -o secondarycache=none \
      -o com.sun:auto-snapshot=false turtle/swap

mkswap -f /dev/turtle/swap
swapon /dev/turtle/swap
