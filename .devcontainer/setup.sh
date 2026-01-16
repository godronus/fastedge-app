#!/bin/bash
set -e

echo "🚀 Setting up FastEdge development environment..."

# Install WASM targets for Rust
echo "📦 Installing Rust WASM targets..."
rustup target add wasm32-wasip1
rustup target add wasm32-unknown-unknown

# Install wasm-pack for Rust->WASM builds
echo "📦 Installing wasm-pack..."
cargo install wasm-pack

# Install FastEdge SDK
echo "📦 Installing FastEdge SDK..."
npm install -g @gcoredev/fastedge-sdk-js

# Install useful WASM tools
echo "📦 Installing wasmtime (WASM runtime)..."
curl https://wasmtime.dev/install.sh -sSf | bash

# Make CLI tools available
echo 'export PATH="$HOME/.wasmtime/bin:$PATH"' >> ~/.bashrc

echo "✅ Setup complete!"
echo ""
echo "🎯 Available commands:"
echo "  - rustc --target wasm32-wasip1    # Compile Rust to WASM"
echo "  - wasm-pack build                  # Build Rust WASM packages"
echo "  - wasmtime run <file.wasm>        # Test WASM locally"
echo ""
echo "💡 Next: Run 'bash .devcontainer/start.sh' to create a new FastEdge app"
