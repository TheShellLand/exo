#!/bin/bash

# show all deployments

set -xe

kubectl delete pod -n $@
