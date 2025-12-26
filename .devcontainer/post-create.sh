#!/bin/bash
set -e

sudo sysctl -w fs.inotify.max_user_watches=1048576
sudo sysctl -w fs.inotify.max_user_instances=512

cd /workspaces/playground

k3d cluster create eda-demo \
    --k3s-arg "--disable=traefik@server:*" \
    --k3s-arg "--disable=servicelb@server:*" \
    --image ghcr.io/kaelemc/k3s-eda:latest

date
make try-eda NO_KIND=yes NO_LB=yes
date

echo "export PATH=$PATH:/workspaces/playground/tools" >> ~/.zshrc

make configure-codespaces-keycloak