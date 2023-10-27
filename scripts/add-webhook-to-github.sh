#!/bin/bash
set -e

name=$1
export token=$2

echo "Adding webhook to GitHub"
export webhook_url=$(scripts/webhook-url.sh "${name}-github" "$token")
github_request=$(jq -n '{"config": {"url": env.webhook_url, "secret": env.token }}')
curl -L --fail --silent --show-error -o /dev/null \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/aelred/$name/hooks \
  -d "$github_request"