#!/bin/bash

# Install and run neo4j-browser
# https://github.com/neo4j/neo4j-browser

apt update
apt install -y git nodejs npm
ln -s `which nodejs` /usr/bin/node

git clone https://github.com/neo4j/neo4j-browser.git
cd neo4j-browser
npm install -g
yarn install
yarn

yarn start
