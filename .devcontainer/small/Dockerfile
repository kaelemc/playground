FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && apt-get install -y \
    make \
    curl \
    jq \
    skopeo \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash