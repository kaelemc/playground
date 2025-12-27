FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && apt-get install -y \
    make \
    curl \
    jq \
    skopeo \
    zstd \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
RUN curl -sL https://github.com/oras-project/oras/releases/download/v1.2.0/oras_1.2.0_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin oras

WORKDIR /root
RUN oras pull ghcr.io/kaelemc/eda:latest