#!/bin/bash

# Get Flask up and running

apt install -y python3-pip

pips="flask flask_login flask_wtf bcrypt neo4j-driver"

for package in $pips; do
  pip install $package
done
