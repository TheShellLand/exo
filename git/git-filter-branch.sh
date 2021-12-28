#!/bin/bash

# delete stuff from git

set -e

if [ -z "$@" ]; then
  echo "missing deletion path"
  exit 1
fi

git filter-branch -f --index-filter "git rm -rf --cached --ignore-unmatch $@" HEAD
