#!/bin/bash
set -e

sudo mkdir -p /etc/docker /workspaces/.docker-data
echo '{"data-root": "/workspaces/.docker-data"}' | sudo tee /etc/docker/daemon.json

sudo pkill dockerd || true
sleep 1
sudo dockerd > /dev/null 2>&1 &

echo "Waiting for Docker daemon..."
until docker info > /dev/null 2>&1; do
    sleep 1
done
echo "Docker daemon is ready"

docker pull ghcr.io/kaelemc/k3s-eda:latest-zstd
docker tag ghcr.io/kaelemc/k3s-eda:latest-zstd k3s-eda:latest
# sudo zstd -d -c /root/eda.tar.zst | docker load
# sudo rm /root/eda.tar.zst
