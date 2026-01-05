#!/bin/bash
set -e

cd /workspaces/playground

echo "Waiting for Docker daemon..."
until docker info > /dev/null 2>&1; do
    sleep 1
done
echo "Docker daemon is ready"

date
make try-eda NO_KIND=yes NO_LB=yes
date

make configure-codespaces-keycloak