#!/bin/bash

# webtop start

cd "$(dirname $0)" && set -e 

BASEDIR="$(pwd)"


if [ ! -z "$PROFILE" ]; then 
  PROFILE=$PROFILE
  VOLUME="-v $PROFILE:/config"
else
  VOLUME=""
fi

if [ -z "$TAG" ]; then
  TAG=debian-xfce
fi 

echo "http://localhost:3000/"
echo ""
echo "https://localhost:3001/"
echo ""

set -xe

docker rm -f webtop 2>/dev/null || true

LOCAL_PORT="3000:3000"
LOCAL_PORT_HTTPS="3001:3001"

docker run \
  -d \
  --name webtop \
  --rm -it \
  -p $LOCAL_PORT \
  -p $LOCAL_PORT_HTTPS \
  --shm-size="8gb" \
  $VOLUME \
  ghcr.io/linuxserver/webtop:$TAG &


i=1
while true; do 
  if docker ps | grep webtop; then 
    break
  fi 
  sleep $i
  i=$(($i+1))
done 

docker logs webtop -f

