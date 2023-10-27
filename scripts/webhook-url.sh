#!/bin/bash
set -e

name=$1
token=$2
webhook_sha=$(echo -n "${token}${name}flux-system" | shasum -a 256 | cut -d ' ' -f1)
echo "https://webhooks.flux.ael.red/hook/$webhook_sha"