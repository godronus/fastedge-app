#!/bin/bash
# Interactive template selector for FastEdge Apps

# Check if already initialized
if [ -f ".devcontainer/.codespace-initialized" ]; then
    echo "╔════════════════════════════════════════════╗"
    echo "║   FastEdge Application Codespace Started   ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "👋 Welcome back! Your FastEdge application codespace is up and running again."
    echo ""
    exit 0
fi

echo "╔════════════════════════════════════════════╗"
echo "║   FastEdge Application Codespace Created   ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo ""
echo "Validating your environment..."
# Check if GCORE_API_TOKEN is set
if [ -z "$GCORE_API_TOKEN" ]; then
    echo "⚠️  GCORE_API_TOKEN not found. Setting up secret..."
    echo ""

    # Trigger the VS Code command
    echo "fastedge.setup-codespace-secret" > .vscode/.fastedge-run-command

    # Wait for the secret to be created (poll for up to 2 minutes)
    echo "Waiting for secret configuration to complete..."
    TIMEOUT=120
    ELAPSED=0
    SECRET_SET=false

    while [ $ELAPSED -lt $TIMEOUT ]; do
        # Check if secret exists using gh CLI
        if gh secret list --app codespaces --user --json name 2>/dev/null | grep -q "GCORE_API_TOKEN"; then
            SECRET_SET=true
            break
        fi
        sleep 2
        ELAPSED=$((ELAPSED + 2))
        echo -n "."
    done

    echo ""

    if [ "$SECRET_SET" = true ]; then
        echo "✅ Secret configured successfully!"
        echo ""
        echo "⚠️  Note: You'll need to REBUILD the codespace for the secret to be available."
        echo "    The secret is now saved but not yet loaded into this environment."
        echo ""
    else
        echo "⏱️  Secret setup is taking longer than expected or was cancelled."
        echo ""
        echo "You can set it up later by:"
        echo "1. Running: Command Palette > FastEdge (Setup Codespace Secret)"
        echo "2. Or manually via GitHub repository Settings > Secrets > Codespaces"
        echo ""
    fi
fi
echo "🎉 Your FastEdge codespace is ready."
echo ""

# Prompt user for setup method
echo "How would you like to create your FastEdge application?"
echo ""
echo "1) Use AI Agent (Recommended) - Let GitHub Copilot guide you"
echo "2) Setup Manually - Interactive CLI wizard"
echo ""
read -p "Enter your choice (1 or 2) [default: 1]: " setup_choice
setup_choice=${setup_choice:-1}

if [ "$setup_choice" = "1" ]; then
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🤖 AI Agent Setup"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "To create your FastEdge application with AI assistance:"
    echo ""
    echo "1. Open GitHub Copilot Chat (Ctrl+Alt+I or Cmd+Shift+I)"
    echo "2. Type: /createFastEdgeApp"
    echo "3. Follow the prompts to configure your application"
    echo ""
    echo "The AI will help you choose the right template and"
    echo "configure your application based on your needs."
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
elif [ "$setup_choice" = "2" ]; then
    echo ""
    echo "Starting manual setup wizard..."
    echo ""
    npx create-fastedge-app . --codespaces
else
    echo ""
    echo "Invalid choice. Please restart the codespace and try again."
    exit 1
fi

# Mark as initialized
touch .devcontainer/.codespace-initialized

# Open the CODESPACE_README
code CODESPACE_README.md

# Open the README
code README.md

