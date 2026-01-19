#!/bin/bash
set -e

# Marker file to prevent re-running setup
MARKER_FILE="$HOME/.fastedge-setup-complete"

if [ -f "$MARKER_FILE" ]; then
    echo "✅ FastEdge environment already set up (skipping)"
    exit 0
fi

echo "🚀 Setting up FastEdge development environment..."

# Install WASM targets for Rust (idempotent)
echo "📦 Installing Rust WASM targets..."
rustup target add wasm32-wasip1 2>/dev/null || echo "  ↳ wasm32-wasip1 already installed"
rustup target add wasm32-unknown-unknown 2>/dev/null || echo "  ↳ wasm32-unknown-unknown already installed"

# Install FastEdge SDK (check if exists)
if ! npm list -g @gcoredev/fastedge-sdk-js &> /dev/null; then
    echo "📦 Installing FastEdge SDK..."
    npm install -g @gcoredev/fastedge-sdk-js
else
    echo "📦 FastEdge SDK already installed (skipping)"
fi

# Install useful WASM tools (check if exists)
if ! command -v wasmtime &> /dev/null; then
    echo "📦 Installing wasmtime (WASM runtime)..."
    curl https://wasmtime.dev/install.sh -sSf | bash

    # Make CLI tools available
    if ! grep -q "wasmtime/bin" ~/.bashrc; then
        echo 'export PATH="$HOME/.wasmtime/bin:$PATH"' >> ~/.bashrc
    fi
fi

# Create marker file
touch "$MARKER_FILE"

echo "✅ Setup complete!"
echo ""
echo "🎯 Available commands:"
echo "  - rustc --target wasm32-wasip1    # Compile Rust to WASM"
echo ""
echo "💡 Next: Run 'bash .devcontainer/start.sh' to create a new FastEdge app"
