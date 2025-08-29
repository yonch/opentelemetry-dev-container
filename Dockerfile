# Use the OpenTelemetry build container as base
FROM docker.io/otel/opentelemetry-network-build-tools:latest

# Set environment variables
ENV EBPF_NET_SRC=$HOME/opentelemetry-network

# Install additional packages
RUN set -ex; \
    sudo apt-get update; \
    sudo apt-get install -y -q openssh-server mosh tmux jq; \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# # for ease of use, add some bash aliases
# RUN echo 'alias apt="sudo apt"' | sudo tee -a /etc/bash.bashrc && \
#     echo 'alias apt-get="sudo apt-get"' | sudo tee -a  /etc/bash.bashrc && \
#     echo 'alias apt-cache="sudo apt-cache"' | sudo tee -a /etc/bash.bashrc && \
#     echo 'alias ll="ls -l"' | sudo tee -a /etc/bash.bashrc

# # Install nvm to manage npm
# RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE="${HOME}/.profile" bash

# # Install node version 20 and claude and gemini
# RUN export NVM_DIR="$HOME/.nvm"; \
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; \
#     nvm install 20 && \
#     npm install -g @anthropic-ai/claude-code @google/gemini-cli

# Install claude
RUN set -ex; \
    sudo apt-get update; \
    sudo apt-get install -y -q npm; \
    sudo npm install -g @anthropic-ai/claude-code; \
    sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /home/user

# Keep container running for dev container usage
CMD ["sleep", "infinity"]
