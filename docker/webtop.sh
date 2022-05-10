#!/bin/bash

# webtop start

if [ -z "$@" ]; then
  echo "missing home folder"
  exit 1
fi

cd $(dirname $0) && set -xe

ARGS="$@"
FOLDER="-v $PWD/$ARGS:/config"

docker run \
  --rm \
  -p 3000:3000 \
  --shm-size="8gb" \
  $FOLDER \
  ghcr.io/linuxserver/webtop

