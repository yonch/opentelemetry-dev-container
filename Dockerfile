# Use the OpenTelemetry build container as base
FROM docker.io/otel/opentelemetry-network-build-tools:latest

# Set environment variables
ENV EBPF_NET_SRC=$HOME/src

# Create the symbolic link from $HOME/src to /workspace/opentelemetry-network
RUN ln -sf /workspace/opentelemetry-network $HOME/src && \
    ln -sf /workspace/out $HOME/out


# for ease of use, add some bash aliases
RUN echo 'alias apt="sudo apt"' | sudo tee -a /etc/bash.bashrc && \
    echo 'alias apt-get="sudo apt-get"' | sudo tee -a  /etc/bash.bashrc && \
    echo 'alias apt-cache="sudo apt-cache"' | sudo tee -a /etc/bash.bashrc && \
    echo 'alias ll="ls -l"' | sudo tee -a /etc/bash.bashrc

# Install nvm to manage npm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE="${HOME}/.profile" bash

# Install node version 20 and claude and gemini
RUN export NVM_DIR="$HOME/.nvm"; \
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; \
    nvm install 20 && \
    npm install -g @anthropic-ai/claude-code @google/gemini-cli

# Create a symbolic link to host .ccache on persistent storage
RUN ln -sf /workspace/.ccache $HOME/.ccache

# We want podman storage on persistent storage
RUN mkdir -p $HOME/.local/share/containers && \
    rm -rf $HOME/.local/share/containers/storage || true && \
    ln -sf /workspace/.local/share/containers/storage $HOME/.local/share/containers/storage

# Set the working directory
WORKDIR /workspace

# Keep container running for dev container usage
CMD ["sleep", "infinity"]
