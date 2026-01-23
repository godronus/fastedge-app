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

# Pre-pull MCP server Docker image for caching in prebuild
echo "📦 Pulling FastEdge MCP server image..."
if docker pull ghcr.io/g-core/fastedge-mcp-server:latest; then
    echo "✅ MCP server image cached successfully"
else
    echo "⚠️  Failed to pull MCP server image (may succeed on container start)"
fi

# Create marker file
touch "$MARKER_FILE"

echo "✅ Setup complete!"
echo ""
echo "🎯 Available commands:"
echo "  - rustc --target wasm32-wasip1    # Compile Rust to WASM"
echo ""
echo "💡 Next: Run 'bash .devcontainer/start.sh' to create a new FastEdge app"
