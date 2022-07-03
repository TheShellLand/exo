#!/bin/bash

# webtop start

if [ -z "$@" ]; then
  FOLDER=""
else
  ARGS="$@"
  FOLDER="-v $PWD/$ARGS:/config"
fi

cd $(dirname $0) && set -x

docker rm -f webtop
docker run \
  --name webtop
  --rm -it \
  -p 3000:3000 \
  --shm-size="8gb" \
  $FOLDER \
  ghcr.io/linuxserver/webtop
