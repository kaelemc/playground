
CLUSTER_DIR="/workspaces/.k3d"
TOKEN="eda-token"

mkdir -p $CLUSTER_DIR

sudo sysctl -w fs.inotify.max_user_watches=1048576
sudo sysctl -w fs.inotify.max_user_instances=512

k3d cluster create eda-demo \
    --volume $CLUSTER_DIR:/var/lib/rancher/k3s@server:* \
    # --volume $CLUSTER_DIR/etc-rancher-node:/etc/rancher/node@server:* \
    --k3s-arg "--disable=traefik@server:*" \
    --k3s-arg "--disable=servicelb@server:*" \
    --token "$TOKEN" \
    --no-lb

cd /workspaces/playground
make try-eda NO_LB=yes NO_KIND=yes