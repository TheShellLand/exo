#!/bin/bash

# create and upload vagrant box

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "Usage: $0 virtualbox_name BOX_NAME VERSION TOKEN"
  echo ""
  VBoxManage list vms
  echo ""
  exit 1
elif [ ! $(which jq) ]; then
  echo "*** requires jq ***"
  echo "*** apt install jq ***"
  exit 1
fi

set -xe

VBOX="$1"
PACKAGE="package.box"
USERNAME="theshellland"
BOX_NAME="$2"
VERSION="$3"
PROVIDER_NAME="virtualbox"
ACCESS_TOKEN="$4"

if [ ! -f "$PACKAGE" ]; then
  vagrant package --base "$VBOX"
fi

UPLOAD_URL=$(curl -s "https://vagrantcloud.com/api/v1/box/$USERNAME/$BOX_NAME/version/$VERSION/provider/$PROVIDER_NAME/upload?access_token=$ACCESS_TOKEN" | jq -r ".upload_path" )

curl -v -X PUT --upload-file "$PACKAGE" "$UPLOAD_URL"

