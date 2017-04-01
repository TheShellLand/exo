#!/bin/bash

# Let's Encrypt script

add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install certbot

certbot certonly

exit 0

