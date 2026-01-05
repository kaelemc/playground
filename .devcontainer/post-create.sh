#!/bin/bash
set -e

sysctl -w fs.inotify.max_user_watches=1048576
sysctl -w fs.inotify.max_user_instances=512

# echo "Waiting for Docker daemon..."
# until docker info > /dev/null 2>&1; do
#     sleep 1
# done
# echo "Docker daemon is ready"

cd /workspaces/playground

date
make try-eda NO_KIND=yes NO_LB=yes
date

make configure-codespaces-keycloak