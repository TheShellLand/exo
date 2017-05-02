#!/bin/bash

# Enable Ubuntu Suspend-to-RAM
# https://help.ubuntu.com/community/SuspendHowto

if [ ! $(grep apm /etc/modules) ]; then
    echo "apm" >> /etc/modules
fi

# TODO: Edit /etc/defaults/grub

cat >> /etc/modprobe.d/blacklist <<EOF
blacklist shpchp
blacklist pciehp
EOF

# Reboot
