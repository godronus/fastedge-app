#!/bin/bash
# Interactive template selector for FastEdge Apps

# Check if already initialized
if [ -f ".devcontainer/codespace-initialized" ]; then
    exit 0
fi

echo "╔════════════════════════════════════════════╗"
echo "║   FastEdge Application Codespace Created   ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "🎉 Done! Your FastEdge codespace is ready."
echo ""
echo ""
echo "You will now be prompted to create a new FastEdge application."
echo ""
echo "If you prefer to set up your project manually, you can exit this script now (Ctrl+C) and create a new directory for your project."
echo ""
echo "OR"
echo ""
echo "Use the MCP Server! Exit this script now (Ctrl+C) and run '/createFastEdgeApp' with your favourite AI Agent."
echo ""

npx create-fastedge-app . --codespaces

# Mark as initialized
touch .devcontainer/codespace-initialized
