FROM registry:2 AS registry
RUN apk add --no-cache skopeo jq
COPY tars/ /tmp/tars/
RUN registry serve /etc/docker/registry/config.yml & \
    until wget -qO- http://127.0.0.1:5000/v2/; do sleep 1; done && \
    for tar in /tmp/tars/*.tar; do \
        ref=$(tar -xOf "$tar" manifest.json | jq -r '.[0].RepoTags[0]'); \
        localref=$(echo "$ref" | sed 's|^ghcr\.io/||'); \
        echo "Loading $tar -> localhost:5000/$localref"; \
        skopeo copy --dest-tls-verify=false "docker-archive:$tar" "docker://localhost:5000/$localref"; \
    done

# ghcr.io/kaelemc/eda-devcontainer:latest
FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update && apt-get install -y \
    make \
    curl \
    jq \
    skopeo \
    zstd \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

COPY --from=registry /var/lib/registry /opt/registry-data