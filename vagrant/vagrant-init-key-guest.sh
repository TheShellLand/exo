#!/bin/bash

# prep vagrant box for building

set -xe

VAGRANT_PUB="https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub"

sudo apt autoremove -y
sudo apt autoclean -y
sudo apt clean -y
sudo hostnamectl set-hostname ecorp
curl $VAGRANT_PUB > ~/.ssh/authorized_keys
echo "" > ~/.bash_history
sudo shutdown now
