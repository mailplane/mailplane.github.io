#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

docker_host=$(docker context inspect --format '{{.Endpoints.docker.Host}}')
docker_config=$(mktemp -d)
trap 'rm -rf "$docker_config"' EXIT
printf '{}\n' > "$docker_config/config.json"

echo "Lokale Vorschau: http://localhost:4000"

DOCKER_CONFIG="$docker_config" DOCKER_HOST="$docker_host" \
  docker run --rm -it \
    -p 127.0.0.1:4000:4000 \
    -v "$PWD:/srv/jekyll" \
    jekyll/jekyll:4 \
    jekyll serve --host 0.0.0.0 --force_polling
