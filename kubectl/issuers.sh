#!/bin/bash

# show all deployments

set -xe

kubectl get issuer --namespace cert-manager
kubectl get certificate -o wide --namespace cert-manager