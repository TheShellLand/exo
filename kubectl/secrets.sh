#!/bin/bash

# show all deployments

set -xe

if [ "$2" == "" ]; then
  kubectl get secrets --all-namespaces
else
  kubectl get secrets -n $@
fi
