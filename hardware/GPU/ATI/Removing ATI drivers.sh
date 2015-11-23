#!/usr/bin/env bash

# A few references
#  https://askubuntu.com/questions/74171/is-my-ati-graphics-card-supported-in-ubuntu


#
# Revert back to the open source drivers
#

# After installing drivers from deb packages
# Remove all the fglrx traces from your system:

sudo apt-get remove --purge fglrx fglrx_* fglrx-amdcccle* fglrx-dev*

# Remove your xorg.conf
sudo rm /etc/X11/xorg.conf

# Reinstall xorg
# For 32bits systems
sudo apt-get install --reinstall xserver-xorg-core libgl1-mesa-glx libgl1-mesa-dri

# For 64bits systems
sudo apt-get install --reinstall libgl1-mesa-glx:i386 libgl1-mesa-glx:amd64 libgl1-mesa-dri:i386 libgl1-mesa-dri:amd64 xserver-xorg-core

# Configure Xorg
sudo dpkg-reconfigure xserver-xorg

# Reboot:
sudo reboot

# After the reboot all the fglrx packages will be gone, you will be using default ones.


#
# After installing drivers from ATI binary
#

# Remove all the ATI driver files:
sudo sh /usr/share/ati/fglrx-uninstall.sh

# Remove your xorg.conf
sudo rm /etc/X11/xorg.conf

# Reinstall xorg
# For 32bits systems
sudo apt-get install --reinstall xserver-xorg-core libgl1-mesa-glx libgl1-mesa-dri

# For 64bits systems
sudo apt-get install --reinstall libgl1-mesa-glx:i386 libgl1-mesa-glx:amd64 libgl1-mesa-dri:i386 libgl1-mesa-dri:amd64 xserver-xorg-core

# Configure Xorg
sudo dpkg-reconfigure xserver-xorg

# Reboot:
sudo reboot

# After the reboot all the fglrx drivers will be gone, you will be using default ones.