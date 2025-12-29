#!/bin/bash
set -e

CACHE_DIR="/workspaces/.eda"

sudo sysctl -w fs.inotify.max_user_watches=1048576
sudo sysctl -w fs.inotify.max_user_instances=512

date
docker load -i "$CACHE_DIR/eda.tar"
date
rm "$CACHE_DIR/eda.tar"

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