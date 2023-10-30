#!/bin/bash
set -e

export name=$1
export image=${2:-$name}

echo "Creating service manifest"
envsubst '${name}' '${image}' < scripts/service-template.yml > "services/$name.yml"

echo "Creating GitHub webhook token"
export github_webhook_token=$(scripts/create-token.sh "$name-github-webhook-token")
scripts/add-webhook-to-github.sh "$name" "$github_webhook_token"

echo "Creating DockerHub webhook token"
export dockerhub_webhook_token=$(scripts/create-token.sh "$name-dockerhub-webhook-token")
export dockerhub_webhook_url=$(scripts/webhook-url.sh "${name}-dockerhub" "$dockerhub_webhook_token")
echo "Add URL $dockerhub_webhook_url to webhooks in DockerHub"
open "https://hub.docker.com/repository/docker/aelred/${image}/webhooks"