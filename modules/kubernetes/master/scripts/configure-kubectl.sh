#!/bin/sh -x

echo "Configuring the kubectl client"
kubectl config set-cluster digital-ocean-cluster --server=https://${MASTER_IP}:6443 --insecure-skip-tls-verify=true

scp -o "StrictHostKeyChecking no" root@${MASTER_IP}:.ssh/thalasoft.* ~/.ssh/.
