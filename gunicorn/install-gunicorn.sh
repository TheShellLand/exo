#!/bin/bash

# Install full gunicorn + flask environment

apt update
apt install -y python3-pip 
pip3 install gunicorn
pip3 install flask
pip3 install flask-login
pip3 install flask_wtf
pip3 install neo4j-driver
pip3 install bcrypt
touch '/var/log/gunicorn.log'
touch '/var/log/gunicorn-error.log'
chown nobody:nogroup '/var/log/gunicorn.log'
chown nobody:nogroup '/var/log/gunicorn-error.log'
