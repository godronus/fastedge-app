# Project Overview - FastEdge Codespace Template

## What Is This?

This is a **zero-setup GitHub Codespace template** for building FastEdge edge applications. Everything you need to develop, test, and deploy edge applications is pre-configured and ready to use.

## Quick Facts

- **Purpose**: Build WebAssembly-based edge applications
- **Platform**: FastEdge by G-Core
- **Setup Time**: 0 minutes (it's already done!)
- **Languages**: JavaScript, TypeScript, Rust, AssemblyScript
- **Deployment**: Global edge network via MCP tools

---

## What's Included

### 1. FastEdge MCP Server

**Location**: `FastEdge-mcp-server/`

**What it does**: Provides tools for building and deploying FastEdge applications

**Tools available**:
- `scaffold-fastedge-project` - Create new projects from templates
- `build-wasm` - Compile source code to WebAssembly
- `upload-binary` - Upload WASM to FastEdge cloud
- `update-or-create-app` - Deploy or update applications
- `update-env-vars-app` - Configure environment variables
- `get-secret-id` - Manage secrets

### 2. FastEdge Debugger

**Location**: `fastedge-debugger/`

**What it does**: Local testing runtime for FastEdge applications

**Features**:
- Web UI for visual testing (port 5179)
- REST API for programmatic testing
- WebSocket for real-time logs
- HTTP and CDN application modes
- Environment variable configuration

### 3. VSCode Extension

**Location**: `FastEdge-vscode/`

**What it does**: IDE integration and helpers

**Features**:
- Generate launch.json for debugging
- Generate mcp.json for MCP configuration
- Setup Codespace secrets
- Compiler integration
- Configuration helpers

### 4. Skills System

**Location**: `.claude/skills/`

**What it does**: Task-specific guidance for AI agents

**Skills included**:
- `codespace-setup` - Codespace configuration
- `fastedge-quickstart` - Getting started guide
- More skills added when creating projects

---

## The Workflow

### Create → Test → Deploy

This template enforces best practices:

1. **Create**: Use MCP to scaffold projects
2. **Test**: Use debugger to test locally
3. **Deploy**: Use MCP to deploy to production

**Why this matters**:
- Faster iteration (no deployment wait)
- Safer development (test before prod)
- Better debugging (real-time logs)
- Lower costs (no edge compute during dev)

---

## Technology Stack

### Build Tools

- **Node.js 20+** - JavaScript/TypeScript development
- **Rust** - High-performance applications
- **FastEdge SDK** - Official SDK for edge apps
- **esbuild** - Fast JavaScript bundling

### Testing Tools

- **fastedge-debugger** - Local runtime
- **REST API** - Programmatic testing
- **WebSocket** - Real-time logging

### Deployment Tools

- **MCP Server** - Model Context Protocol integration
- **FastEdge API** - Cloud deployment
- **Docker** - Containerized build environment

---

## Project Structure

```
fastedge-template/
├── claude.md                     # AI agent instructions
├── context/                      # Documentation
│   ├── CONTEXT_INDEX.md         # Start here
│   ├── PROJECT_OVERVIEW.md      # This file
│   ├── WORKFLOW_GUIDE.md        # Development workflow
│   └── CODESPACE_GUIDE.md       # Codespace features
│
├── .claude/skills/               # Task guidance
│
├── .devcontainer/                # Codespace config
│   ├── devcontainer.json
│   ├── Dockerfile
│   └── start.sh
│
├── fastedge-debugger/            # Testing server
├── FastEdge-mcp-server/          # Build & deploy tools
├── FastEdge-vscode/              # IDE extension
│
└── [your projects]/              # Your applications
```

---

## How It Works

### 1. Codespace Initialization

When you create a Codespace:

1. Container builds from `.devcontainer/Dockerfile`
2. Tools are installed (Node, Rust, etc.)
3. Repositories are cloned
4. MCP server is configured
5. `start.sh` runs initialization
6. You're ready to code!

### 2. Creating Applications

Use MCP tool `scaffold-fastedge-project`:

1. Choose template (http-base, http-react, cdn-base, etc.)
2. Choose language (JavaScript, TypeScript, Rust, etc.)
3. Project created with:
   - Source code
   - Build configuration
   - Skills directory
   - Dependencies

### 3. Testing Locally

Use fastedge-debugger:

1. Build your application: `npm run build`
2. Start debugger: `cd fastedge-debugger && npm start`
3. Load WASM via web UI or REST API
4. Send test requests
5. Check logs and responses
6. Iterate until tests pass

### 4. Deploying to Production

Use MCP tools:

1. `build-wasm` - Compile to WebAssembly
2. `upload-binary` - Upload to FastEdge cloud
3. `update-or-create-app` - Deploy application
4. Application runs on global edge network

---

## What Can You Build?

### HTTP Applications

Standard request/response handling:

- **API Gateways** - Route and transform requests
- **Microservices** - Edge-native services
- **Static Sites** - React, Vite applications
- **Authentication** - JWT validation at edge
- **Rate Limiting** - Protect your APIs

### CDN Applications

CDN proxy enhancements:

- **Request Modification** - Transform incoming requests
- **Response Modification** - Inject or modify content
- **A/B Testing** - Traffic splitting
- **Geo-Routing** - Location-based routing
- **Caching Logic** - Custom cache rules

### Examples

See `.claude/skills/fastedge-examples/` for patterns and examples from the FastEdge Examples repository.

---

## Key Concepts

### WebAssembly (WASM)

FastEdge runs WebAssembly modules at the edge. Your code is compiled to WASM, which provides:

- **Performance** - Near-native speed
- **Security** - Sandboxed execution
- **Portability** - Runs everywhere
- **Multi-language** - Write in any language that compiles to WASM

### Edge Computing

Your code runs at G-Core's global edge network:

- **Low Latency** - Close to users
- **High Availability** - Distributed globally
- **Scalability** - Auto-scaling
- **Cost-Effective** - Pay per request

### Model Context Protocol (MCP)

Standardized way for AI agents to access tools:

- **Tools** - Callable functions (build, deploy, etc.)
- **Resources** - Static content (docs, examples)
- **Prompts** - Workflows (automated deployment)

---

## Skills vs Documentation

### Documentation (context/ directory)

- **Purpose**: Explain the template and Codespace
- **Audience**: Humans and AI agents
- **Content**: Overview, guides, reference
- **Usage**: Read when learning the system

### Skills (.claude/skills/ directory)

- **Purpose**: Task-specific guidance
- **Audience**: AI agents (but humans can read too)
- **Content**: Patterns, examples, best practices
- **Usage**: Discovered automatically by Claude

**Key difference**: Skills are more focused and actionable. Documentation is more explanatory.

---

## Common Questions

### Q: Do I need to install anything locally?

**A**: No! Everything runs in the Codespace. Just open and start coding.

### Q: How do I test my application?

**A**: Use the fastedge-debugger. See WORKFLOW_GUIDE.md for details.

### Q: Can I deploy to production from here?

**A**: Yes! Use MCP tools to deploy directly from the Codespace.

### Q: What languages are supported?

**A**: JavaScript, TypeScript, Rust, and AssemblyScript. Choose when scaffolding.

### Q: Where do my applications run?

**A**: On G-Core's global edge network, close to your users.

### Q: Can I use npm packages?

**A**: Yes, but be mindful of bundle size. Edge apps should be lightweight.

### Q: How do I manage secrets?

**A**: Use GitHub Codespace Secrets or `.env` files. See CODESPACE_GUIDE.md.

### Q: Is the debugger production-ready?

**A**: No, it's for local testing only. Always test locally before deploying.

---

## Getting Started

### First Steps

1. **Read**: `context/CONTEXT_INDEX.md` (documentation map)
2. **Read**: `context/WORKFLOW_GUIDE.md` (development workflow)
3. **Try**: Use MCP to create your first application
4. **Test**: Load it in the debugger
5. **Deploy**: Push to production when ready

### Next Steps

- **Explore**: Browse `.claude/skills/` for guidance
- **Learn**: Check FastEdge SDK documentation
- **Examples**: Visit the FastEdge Examples repository
- **Build**: Create your edge application!

---

## Resources

### Internal

- **Context**: Documentation in `context/`
- **Skills**: Guidance in `.claude/skills/`
- **READMEs**: In each tool directory

### External

- **FastEdge SDK**: https://g-core.github.io/FastEdge-sdk-js/
- **Examples**: https://github.com/G-Core/FastEdge-examples
- **G-Core Docs**: https://gcore.com/docs/fastedge
- **MCP Spec**: https://modelcontextprotocol.io/

---

## Philosophy

This template embodies several key principles:

1. **Zero Setup** - Everything pre-configured
2. **Test First** - Always test locally before deploying
3. **Skills-Based** - Discovery over documentation
4. **Agent-Friendly** - Built for AI-assisted development
5. **Production-Ready** - Real tools, real workflows

---

**Ready to build? Start with WORKFLOW_GUIDE.md to learn the development workflow.**

**Last Updated**: February 2026
