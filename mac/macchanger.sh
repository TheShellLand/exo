#!/bin/bash

set -e

read -p "Enter new mac address: " new_mac

set -x

sudo ifconfig en0 lladdr $new_mac
