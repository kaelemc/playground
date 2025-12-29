#!/bin/bash
set -e

sudo sysctl -w fs.inotify.max_user_watches=1048576
sudo sysctl -w fs.inotify.max_user_instances=512

date

sudo mkdir -p /etc/docker
echo '{"data-root": "/workspaces/.docker-data"}' | sudo tee /etc/docker/daemon.json

sudo pkill dockerd || true
sleep 1
sudo dockerd > /dev/null 2>&1 &

echo "Waiting for Docker daemon..."
until docker info > /dev/null 2>&1; do
    sleep 1
done
echo "Docker daemon is ready"

cd /workspaces/playground

k3d cluster create eda-demo \
    --k3s-arg "--disable=traefik@server:*" \
    --k3s-arg "--disable=servicelb@server:*" \
    --image k3s-eda:latest \
    --no-lb

date
make try-eda NO_KIND=yes NO_LB=yes
date

echo "export PATH=$PATH:/workspaces/playground/tools" >> ~/.zshrc

make configure-codespaces-keycloak