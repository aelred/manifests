#!/bin/bash
set -e

name=$1
token=$(head -c 12 /dev/urandom | shasum | cut -d ' ' -f1)

>&2 echo "Adding token to cluster"
kubectl -n flux-system create secret generic "$name" --from-literal=token=$token \
    --save-config --dry-run=client -o yaml | kubectl apply -f -

echo $token