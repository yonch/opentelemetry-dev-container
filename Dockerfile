# Use the OpenTelemetry build container as base
FROM docker.io/otel/opentelemetry-network-build-tools:latest

# Set environment variables
ENV EBPF_NET_SRC=$HOME/opentelemetry-network

# Install additional packages
RUN set -ex; \
    sudo apt-get update; \
    sudo apt-get install -y -q openssh-server mosh tmux jq locales nano; \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Configure locale
RUN set -ex; \
    locale-gen en_US.UTF-8; \
    update-locale LANG=en_US.UTF-8

# Set the working directory
WORKDIR /home/user

# Keep container running for dev container usage
CMD ["sleep", "infinity"]
