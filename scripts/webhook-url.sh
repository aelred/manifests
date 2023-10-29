#!/bin/bash
set -e

name=$1
token=$2

components="${token}${name}flux-system"
>&2 echo "Generating webhook sha from $components"
webhook_sha=$(echo -n "$components" | shasum -a 256 | cut -d ' ' -f1)
echo "https://webhooks.flux.ael.red/hook/$webhook_sha"