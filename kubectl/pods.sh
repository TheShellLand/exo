#!/bin/bash

# show all deployments

set -xe

kubectl get pods --all-namespaces
