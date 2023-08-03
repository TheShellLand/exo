#!/bin/bash

# show all deployments

set -xe

kubectl get deployments --all-namespaces
