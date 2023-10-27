#!/bin/bash
set -e

flux bootstrap github \
  --token-auth \
  --owner=aelred \
  --repository=manifests \
  --branch=main \
  --path=. \
  --personal \
  --components-extra image-reflector-controller,image-automation-controller

# GitHub token is used for adding deploy status updates to commits
kubectl -n flux-system create secret generic github-token --from-literal=token=$GITHUB_TOKEN \
    --save-config --dry-run=client -o yaml | kubectl apply -f -

# Create GitHub webhook token to notify flux when changes are made to manifests
export github_webhook_token=$(scripts/create-token.sh "manifests-github-webhook-token")
scripts/add-webhook-to-github.sh "manifests" "$github_webhook_token"