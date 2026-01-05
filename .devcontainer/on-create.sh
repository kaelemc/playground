#!/bin/bash

sudo sysctl -w fs.inotify.max_user_watches=1048576
sudo sysctl -w fs.inotify.max_user_instances=512

echo "Waiting for Docker daemon..."
until docker info > /dev/null 2>&1; do
    sleep 1
done
echo "Docker daemon is ready"

k3d cluster create eda-demo \
    --k3s-arg "--disable=traefik@server:*" \
    --k3s-arg "--disable=servicelb@server:*" \
    --volume '/opt/images.txt:/opt/images.txt@server:*' \
    --no-lb

TESTTOKEN=$(echo -n "bm9raWEtZWRhLWJvdDpnaHBfZHJOUXhvbWVrYUJrZUg2MXQ5aEk5U2QzTVNoMzF1MUVRMVJ4" | base64 -d)
docker exec -d k3d-eda-demo-server-0 sh -c "cat /opt/images.txt | xargs -P 0 -I {} crictl pull --creds $TESTTOKEN {}"

cd /workspaces/playground
make download-tools
echo "export PATH=$PATH:/workspaces/playground/tools" | sudo tee -a /etc/profile.d/eda-tools.sh