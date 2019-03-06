#!/bin/bash

# Allows entering a password from a terminal-only environment

apt update > /dev/null
echo "
pinentry-program /usr/bin/pinentry-tty
allow-loopback-pinentry" >  ~/.gnupg/gpg-agent.conf

echo ""
echo "gpg-agnet.conf:"
cat ~/.gnupg/gpg-agent.conf
echo ""

if [ -z "$1" ]; then
	echo ""
	echo "usage: $0 /path/to/private.key"
	echo ""
	echo "actual command: gpg --pinentry-mode loopback --import private.key"
else
	gpg --pinentry-mode loopback --import "$1"
fi

