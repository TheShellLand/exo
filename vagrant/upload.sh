#!/bin/bash

# create and upload vagrant box

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Usage: $0 vagrant.box BOX_NAME VERSION TOKEN"
  exit 1
elif [ ! $(which jq) ]; then
  echo "*** requires jq ***"
  echo "*** apt install jq ***"
  exit 1
fi

set -xe

BOX="$1"
USERNAME="theshellland"
BOX_NAME="$2"
VERSION="$3"
PROVIDER_NAME="virtualbox"
ACCESS_TOKEN="$4"
UPLOAD_URL=$(curl -s "https://vagrantcloud.com/api/v1/box/$USERNAME/$BOX_NAME/version/$VERSION/provider/$PROVIDER_NAME/upload?access_token=$ACCESS_TOKEN" | jq -r ".upload_path" )

if [ ! -f "$BOX" ]; then
  vagrant package --output "$BOX"
  curl -X PUT --upload-file "$BOX" "$UPLOAD_URL"
else
  curl -X PUT --upload-file "$BOX" "$UPLOAD_URL"
fi

