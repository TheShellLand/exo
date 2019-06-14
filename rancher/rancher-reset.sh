#!/bin/bash

# Reset Rancher and reinstall


service docker stop && \
umount -rl /var/lib/rancher/ && \
umount -rl /var/lib/docker/ && \
rm -rf /var/lib/rancher/* 
rm -rf /var/lib/docker/*
zfs destroy -r turtle/_ubuntu/rancher/docker
zfs create -o mountpoint=/var/lib/docker/ turtle/_ubuntu/rancher/docker

apt install --reinstall docker-ce

docker run -d --restart=unless-stopped -p 8080:8080 rancher/server:preview


