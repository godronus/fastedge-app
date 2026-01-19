# Use pre-built base image with all heavy dependencies
# This image is built separately and contains: Node.js 24, Rust, WASM targets
FROM ghcr.io/godronus/fastedge-app/base:latest

# Lightweight customizations only (fast!)
USER vscode

# Add any project-specific lightweight setup here
# (empty for now - base image has everything)

# probably want to try and install pnpm here??? @gcoredev/fastedge-sdk-js?

WORKDIR /workspaces
