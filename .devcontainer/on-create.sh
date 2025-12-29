#!/bin/bash
set -e

echo "Waiting for Docker daemon..."
until docker info > /dev/null 2>&1; do
    sleep 1
done
echo "Docker daemon is ready"

docker pull ghcr.io/kaelemc/k3s-eda:latest-zstd
docker tag ghcr.io/kaelemc/k3s-eda:latest-zstd k3s-eda:latest
