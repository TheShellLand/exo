#!/usr/bin/env bash




Official ATI binaries from the ATI site

# To install the latest ATI 12.6 drivers follow this, people are reporting that updating their driver solves some problems with Unity and Gnome-Shell
# You will need to remove all the current fglrx packages from your system and download the driver from the ATI site.
# Remove the fglrx drivers if previously installed them (if any of these returns errors ie: file not found, package not found ignore it)

sudo sh /usr/share/ati/fglrx-uninstall.sh
sudo apt-get remove --purge fglrx fglrx_* fglrx-amdcccle* fglrx-dev*

# Download the newest ATI driver (current version is 12.6)
wget http://www2.ati.com/drivers/linux/amd-driver-installer-12-6-x86.x86_64.run

# If you have a 64 bit system, then install this before anything
sudo apt-get install ia32-libs

# Once downloaded go to the file location and set it to run as executable
cd /path_of_the_file
chmod 755 amd-driver-installer-12-3-x86.x86_64.run

# For 32/64 bit Ubuntu use these steps to install
sh ./amd-driver-installer-12-3-x86.x86_64.run --buildpkg Ubuntu/oneiric
sudo dpkg -i fglrx*.deb

# Once the driver is installed you need to start up a new xorg.conf file with this command
sudo aticonfig --initial -f

# Reboot
sudo reboot
