#!/usr/bin/env bash

# Setup an LXC for remote sessions


# Install x2goserver
apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:x2go/stable
sudo apt-get update
sudo apt-get install -y x2goserver x2goserver-xsession

# Xubuntu
apt install -y xubuntu-desktop

# MATE
#apt install -y mate

# XFCE4
#apt install -y xfce4
