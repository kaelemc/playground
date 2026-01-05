mount --make-rshared /
ln -sf /host-docker.sock /var/run/docker.sock
TESTTOKEN=$(echo -n "bm9raWEtZWRhLWJvdDpnaHBfZHJOUXhvbWVrYUJrZUg2MXQ5aEk5U2QzTVNoMzF1MUVRMVJ4" | base64 -d)
until crictl info >/dev/null 2>&1; do sleep 1; done
setsid bash -c "cat /opt/images.txt | xargs -P 0 -I {} crictl pull --creds $TESTTOKEN {}" >/dev/null 2>&1 &
make download-tools
echo "export PATH=$PATH:/workspaces/k3s-codespaces-test/playground/tools" > /etc/profile.d/eda-tools.sh