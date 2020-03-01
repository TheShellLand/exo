#!/bin/bash

# describe pod

set -xe

if [ "$2" == "" ]; then
  kubectl describe pods -n "$namespace" | less
else
  kubectl describe pods -n $@ | less
fi
