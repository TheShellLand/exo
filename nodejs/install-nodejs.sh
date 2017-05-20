#!/bin/bash

# Install node.js npm

apt update
apt install -y node
ln -s `which nodejs` /usr/bin/node
npm install -g yarn