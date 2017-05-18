#!/bin/bash

# Make a swap file and mount it

swap=/tmp/swap

fallocate -l 1g $swap
mkswap $swap
swapon $swap
