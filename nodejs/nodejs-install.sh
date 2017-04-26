#!/bin/bash

# Install nodejs

apt update
apt install -y node
ln -s `which nodejs` /usr/bin/node
