#!/bin/bash

# Enable Auto Security Upgrades

apt install -y unattended-upgrades
dpkg-reconfigure unattended-upgrades
