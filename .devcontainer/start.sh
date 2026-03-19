#!/bin/bash
# FastEdge Codespace Initialization Script
# Prepares the environment for building edge applications

set -e  # Exit on error

# Colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if already initialized
if [ -f ".devcontainer/.codespace-initialized" ]; then
    echo -e "${GREEN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║   FastEdge Codespace Ready                 ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
    echo ""
    echo "👋 Welcome back! Your FastEdge Codespace is running."
    echo ""
    echo "📚 Documentation:"
    echo "   - Start here: context/CONTEXT_INDEX.md"
    echo "   - Workflow: context/WORKFLOW_GUIDE.md"
    echo "   - Skills: .claude/skills/"
    echo ""
    echo "🚀 Quick Actions:"
    echo "   - Create app: Use MCP tool 'scaffold-fastedge-project'"
    echo "   - Start debugger: cd fastedge-debugger && npm start"
    echo "   - View ports: Check Ports panel (port 5179)"
    echo ""
    exit 0
fi

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   Initializing FastEdge Codespace          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
echo ""

# Function to print section header
print_section() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

# Validate environment
print_section "🔍 Validating Environment"

SECRET_SET=false

# Check for FastEdge API credentials
if [ -z "$GCORE_API_TOKEN" ] && [ -z "$FASTEDGE_API_KEY" ]; then
    echo -e "${YELLOW}⚠️  FastEdge credentials not found${NC}"
    echo ""
    echo "To deploy applications, you need to set FASTEDGE_API_KEY:"
    echo ""
    echo "Option 1: Use VSCode command"
    echo "  1. Open Command Palette (Ctrl+Shift+P)"
    echo "  2. Run: FastEdge (Setup Codespace Secrets)"
    echo ""
    echo "Option 2: Set manually"
    echo "  1. Go to GitHub Settings → Codespaces"
    echo "  2. Add secret: FASTEDGE_API_KEY"
    echo "  3. Rebuild Codespace"
    echo ""
    echo -e "${YELLOW}Note: You can still create and test apps locally without credentials${NC}"
    echo ""
else
    echo -e "${GREEN}✅ FastEdge credentials configured${NC}"
    SECRET_SET=true
fi

# Initialize Docker for MCP server
if [ -n "$GCORE_API_TOKEN" ] || [ -n "$FASTEDGE_API_KEY" ]; then
    print_section "🔧 Initializing MCP Server"

    echo "Waiting for Docker daemon..."
    DOCKER_TIMEOUT=30
    DOCKER_ELAPSED=0

    until docker info >/dev/null 2>&1; do
        if [ $DOCKER_ELAPSED -ge $DOCKER_TIMEOUT ]; then
            echo -e "${YELLOW}⚠️  Docker initialization timeout${NC}"
            echo "   MCP server may not work until Docker is ready"
            break
        fi
        sleep 1
        DOCKER_ELAPSED=$((DOCKER_ELAPSED + 1))
        echo -n "."
    done

    if docker info >/dev/null 2>&1; then
        echo ""
        echo -e "${GREEN}✅ Docker daemon ready${NC}"
        echo -e "${GREEN}✅ MCP server initialized${NC}"
    fi
fi

# Display Codespace information
print_section "📦 Codespace Information"

echo "Available Tools:"
echo "  • FastEdge MCP Server    - Build & deploy tools"
echo "  • fastedge-debugger      - Local testing runtime (port 5179)"
echo "  • FastEdge VSCode Ext    - IDE integration"
echo "  • Node.js $(node --version)"
echo "  • Rust $(rustc --version 2>/dev/null | cut -d' ' -f2 || echo 'N/A')"
echo ""

echo "Ports:"
echo "  • 5179 - FastEdge Debugger (Web UI + REST API)"
echo "  • 5178 - WebSocket logs (optional)"
echo ""

echo "Documentation:"
echo "  • claude.md                    - AI agent instructions"
echo "  • context/CONTEXT_INDEX.md     - Documentation map (start here!)"
echo "  • context/PROJECT_OVERVIEW.md  - What is this Codespace"
echo "  • context/WORKFLOW_GUIDE.md    - Development workflow"
echo "  • context/CODESPACE_GUIDE.md   - Codespace features"
echo ""

echo "Skills:"
echo "  • .claude/skills/codespace-setup/      - Codespace configuration"
echo "  • .claude/skills/fastedge-quickstart/  - Getting started guide"
echo "  • More skills added when creating projects"
echo ""

# Mark as initialized
touch .devcontainer/.codespace-initialized

# Display next steps for AI agents
print_section "🤖 For AI Agents (Claude, Copilot, etc.)"

echo "I've prepared this Codespace for FastEdge development:"
echo ""
echo "1. Read Context:"
echo "   • Start with: context/CONTEXT_INDEX.md (~100 lines)"
echo "   • Then read: context/WORKFLOW_GUIDE.md"
echo "   • Reference skills in .claude/skills/ as needed"
echo ""
echo "2. Create Application:"
echo "   • Use MCP tool: scaffold-fastedge-project"
echo "   • Choose template: http-base, http-react, http-react-hono, cdn-base"
echo "   • Choose language: javascript, typescript, rust, assemblyscript"
echo ""
echo "3. Test Locally:"
echo "   • Build: npm run build"
echo "   • Start debugger: cd fastedge-debugger && npm start"
echo "   • Test via: http://localhost:5179 or REST API"
echo "   • See .claude/skills/fastedge-debugging/ for examples"
echo ""
echo "4. Deploy to Production:"
echo "   • Use MCP tools: build-wasm, upload-binary, update-or-create-app"
echo "   • See .claude/skills/fastedge-deployment/ for workflow"
echo ""
echo "Key Principle: ${GREEN}Create → Test → Deploy${NC}"
echo "  Always test locally with debugger before deploying!"
echo ""

# Display next steps for humans
print_section "👤 For Human Developers"

echo "Welcome to FastEdge Codespace! 🚀"
echo ""
echo "Quick Start:"
echo ""
echo "1. Read Documentation:"
echo "   ${BLUE}code context/CONTEXT_INDEX.md${NC}"
echo ""
echo "2. Create Your First App:"
echo "   Ask Claude: \"Create a FastEdge HTTP application\""
echo "   Or manually: ${BLUE}npx create-fastedge-app my-app${NC}"
echo ""
echo "3. Test Locally:"
echo "   ${BLUE}cd fastedge-debugger && npm start${NC}"
echo "   Open: http://localhost:5179"
echo ""
echo "4. Deploy:"
echo "   Ask Claude: \"Deploy my application to FastEdge\""
echo ""

# Summary
print_section "✨ Initialization Complete"

echo -e "${GREEN}✅ Codespace is ready for FastEdge development!${NC}"
echo ""
echo "Next Steps:"
echo "  1. Read: ${BLUE}context/CONTEXT_INDEX.md${NC} (documentation map)"
echo "  2. Create: Use MCP or Claude to scaffold a project"
echo "  3. Test: Start debugger and test locally"
echo "  4. Deploy: Use MCP tools to deploy to production"
echo ""
echo "Documentation: ${BLUE}context/${NC}"
echo "Skills: ${BLUE}.claude/skills/${NC}"
echo "Tools: FastEdge MCP Server, debugger (port 5179), VSCode extension"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"
echo ""
