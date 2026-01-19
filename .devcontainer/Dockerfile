# Use the base image with all features pre-installed
FROM ghcr.io/godronus/fastedge-app/devcontainer:latest

# Switch to root for installations
USER root

# Install system dependencies in one layer
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Switch to vscode user for user-specific installations
USER vscode

# Install Rust WASM targets (cached layer)
RUN rustup target add wasm32-wasip1 && \
    rustup target add wasm32-unknown-unknown

# Install FastEdge SDK globally (cached layer)
RUN npm install -g @gcoredev/fastedge-sdk-js

# Set up environment
ENV PATH="/home/vscode/.cargo/bin:${PATH}"

# Back to vscode user
USER vscode
WORKDIR /workspaces
