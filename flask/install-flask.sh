#!/bin/bash

# Get Flask up and running

apt update
apt install -y python3-pip

pips="flask 
      flask_login 
      flask_wtf 
      bcrypt 
      neo4j-driver"

pip3 install --upgrade pip

for package in $pips; do
  pip3 install $package
done
