#!/bin/bash
set -e

# Marker file to prevent re-running setup
MARKER_FILE="$HOME/.fastedge-setup-complete"

if [ -f "$MARKER_FILE" ]; then
    echo "✅ FastEdge environment already set up (skipping)"
    exit 0
fi

echo "🚀 Setting up FastEdge development environment..."

## DO any once off setup tasks here..
## At present we have none.. just loading the prebuilt Dockerfile
echo "🔧 Node version: $(node --version)"
echo "🔧 Code version: $(code --version)"

# Create marker file
touch "$MARKER_FILE"

echo "✅ Setup complete!"
echo ""
echo "🎯 Available commands:"
echo "  - rustc --target wasm32-wasip1    # Compile Rust to WASM"
echo ""
echo "💡 Next: Run 'bash .devcontainer/start.sh' to create a new FastEdge app"
