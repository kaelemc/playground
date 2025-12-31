#!/bin/bash
set -e

sudo sysctl -w fs.inotify.max_user_watches=1048576
sudo sysctl -w fs.inotify.max_user_instances=512

echo "Waiting for Docker daemon..."
until docker info > /dev/null 2>&1; do
    sleep 1
done
echo "Docker daemon is ready"

cd /workspaces/playground

docker run -d \
    --name registry \
    --restart always \
    -p 5000:5000 \
    -v /opt/registry-data:/var/lib/registry \
    registry:2

until curl -sf http://localhost:5000/v2/; do sleep 1; done
echo "Registry up"

k3d cluster create eda-demo \
    --k3s-arg "--disable=traefik@server:*" \
    --k3s-arg "--disable=servicelb@server:*" \
    --no-lb \
    --registry-config /workspaces/playground/configs/k3d-registry.yaml

date
make try-eda NO_KIND=yes NO_LB=yes
date

echo "export PATH=$PATH:/workspaces/playground/tools" >> ~/.zshrc

make configure-codespaces-keycloak