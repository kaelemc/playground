#!/bin/bash
# Runs during prebuild - only decompress the image archive
set -e

CACHE_DIR="/workspaces/.eda"

mkdir -p $CACHE_DIR
sudo zstd -d -c /root/eda.tar.zst -o "$CACHE_DIR/eda.tar"
sudo rm /root/eda.tar.zst
