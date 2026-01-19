# Use official devcontainer base image with Node and Rust
FROM mcr.microsoft.com/devcontainers/base:debian

# Switch to root for installations
USER root

# Install Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get update && apt-get install -y --no-install-recommends \
    nodejs \
    build-essential \
    curl \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Rust for vscode user
USER vscode
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal && \
    . "$HOME/.cargo/env" && \
    rustup target add wasm32-wasip1 && \
    rustup target add wasm32-unknown-unknown && \
    rustup component add rust-analyzer rustfmt clippy

# Set up environment
ENV PATH="/home/vscode/.cargo/bin:${PATH}"

# Back to vscode user
USER vscode
WORKDIR /workspaces
