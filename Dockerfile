# Use the OpenTelemetry build container as base
FROM docker.io/yonchco/opentelemetry-network-build-tools:latest

# Set environment variables
ENV EBPF_NET_SRC=$HOME/src

# Create the symbolic link from $HOME/src to /workspace/opentelemetry-network
RUN ln -sf /workspace/opentelemetry-network $HOME/src

# Install Claude CLI and Gemini CLI
RUN apt-get update && \
    apt-get install -y -q npm && \
    npm install -g @anthropic-ai/claude-code @google/gemini-cli && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Keep container running for dev container usage
CMD ["sleep", "infinity"]