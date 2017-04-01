#!/bin/bash

# Let's Encrypt script

apt install -y software-properties-common
add-apt-repository -y ppa:certbot/certbot
apt-get update
apt-get install -y certbot

certbot certonly

exit 0

