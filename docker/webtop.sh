#!/bin/bash

# webtop start

if [ -z "$@" ]; then
  FOLDER=""
else
  ARGS="$@"
  FOLDER="-v $PWD/$ARGS:/config"
fi

cd $(dirname $0) && set -xe

docker run \
  --rm -it \
  -p 3000:3000 \
  --shm-size="8gb" \
  $FOLDER \
  ghcr.io/linuxserver/webtop
