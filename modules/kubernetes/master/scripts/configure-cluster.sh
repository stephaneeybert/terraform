#!/bin/sh -x

echo "Configuring a cluster in the client"

cd
mkdir -p .kube
kubectl config set-cluster digital-ocean-cluster --server=https://${MASTER_IP}:6443 --insecure-skip-tls-verify=true

