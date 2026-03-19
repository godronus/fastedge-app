# Context Index - FastEdge Codespace Template

## 🎯 Start Here

**Welcome to the FastEdge Codespace!** This is your zero-setup environment for building edge applications.

This file is your **map** to all documentation. Read this first, then navigate to specific docs based on your task.

---

## Quick Start

### First Time Here?

1. **Read this file** (you're doing it!) - ~5 minutes
2. **Read PROJECT_OVERVIEW.md** - What is this template? (~2 minutes)
3. **Read WORKFLOW_GUIDE.md** - How to create, test, deploy (~5 minutes)
4. **Start building** - Use MCP to scaffold your first app

### Returning to Work?

Use the **Decision Tree** below to find exactly what you need.

---

## Documentation Map

### Core Documentation (Start Here)

| File | Size | When to Read | What You'll Learn |
|------|------|--------------|-------------------|
| **CONTEXT_INDEX.md** | ~100 lines | **Always first** | Documentation map, decision tree |
| **PROJECT_OVERVIEW.md** | ~150 lines | First time | What is this template, quick start |
| **WORKFLOW_GUIDE.md** | ~300 lines | Before coding | Create → Test → Deploy workflow |
| **CODESPACE_GUIDE.md** | ~200 lines | Using Codespace | Ports, secrets, configuration |

### Skills Directory

| Skill | When to Use | What It Covers |
|-------|-------------|----------------|
| **codespace-setup** | Setting up Codespace | Configuration, tools, ports |
| **fastedge-quickstart** | First time | Getting started guide |
| **fastedge-development** | Building apps | SDK, patterns, examples (in generated projects) |
| **fastedge-debugging** | Testing | Local debugger usage (in generated projects) |
| **fastedge-deployment** | Deploying | MCP tools, production (in generated projects) |
| **fastedge-examples** | Learning | Example patterns (in generated projects) |

---

## Decision Tree: What Should I Read?

### I want to understand what this Codespace provides
→ Read: **PROJECT_OVERVIEW.md**

### I want to create a new FastEdge application
→ Read: **WORKFLOW_GUIDE.md** (Create section)
→ Use: MCP tool `scaffold-fastedge-project`
→ Reference: `.claude/skills/fastedge-development/` (after project created)

### I want to test my application locally
→ Read: **WORKFLOW_GUIDE.md** (Test section)
→ Reference: `.claude/skills/fastedge-debugging/`
→ Start: `cd fastedge-debugger && npm start`

### I want to deploy to production
→ Read: **WORKFLOW_GUIDE.md** (Deploy section)
→ Reference: `.claude/skills/fastedge-deployment/`
→ Use: MCP tools (`build-wasm`, `upload-binary`, etc.)

### I need to configure Codespace settings
→ Read: **CODESPACE_GUIDE.md**
→ Reference: `.claude/skills/codespace-setup/`

### I want to understand the development workflow
→ Read: **WORKFLOW_GUIDE.md** (complete guide)

### I'm looking for code examples
→ Reference: `.claude/skills/fastedge-examples/`
→ Visit: https://github.com/G-Core/FastEdge-examples

### I have an error or bug
→ Check: Debugger logs (port 5179)
→ Reference: `.claude/skills/fastedge-debugging/` (troubleshooting)
→ Read: **WORKFLOW_GUIDE.md** (testing section)

### I want to add environment variables
→ Read: **CODESPACE_GUIDE.md** (secrets section)
→ Reference: `.claude/skills/fastedge-development/` (env vars pattern)

---

## File Organization

```
fastedge-template/
├── claude.md                     # AI agent instructions (read first!)
├── context/                      # Documentation
│   ├── CONTEXT_INDEX.md         # ← You are here
│   ├── PROJECT_OVERVIEW.md      # What is this template
│   ├── WORKFLOW_GUIDE.md        # Create → Test → Deploy
│   └── CODESPACE_GUIDE.md       # Codespace features
│
├── .claude/skills/               # Task-specific guidance
│   ├── codespace-setup/         # Codespace configuration
│   └── fastedge-quickstart/     # Getting started
│
├── .devcontainer/                # Codespace configuration
│   ├── devcontainer.json        # Container settings
│   ├── Dockerfile               # Build environment
│   └── start.sh                 # Initialization script
│
├── fastedge-debugger/            # Local testing server
├── FastEdge-mcp-server/          # MCP tools
├── FastEdge-vscode/              # VSCode extension
└── [your projects here]          # Created applications
```

---

## Available Tools in This Codespace

### MCP Server (Build & Deploy)

Pre-configured and ready to use:

- `scaffold-fastedge-project` - Create new projects
- `build-wasm` - Compile to WebAssembly
- `upload-binary` - Upload to FastEdge
- `update-or-create-app` - Deploy application
- `update-env-vars-app` - Configure environment
- `get-secret-id` - Manage secrets

**Configuration**: See FastEdge-mcp-server/README.md

### FastEdge Debugger (Local Testing)

Test applications before deploying:

- **Web UI**: http://localhost:5179
- **REST API**: Full programmatic control
- **WebSocket**: Real-time log streaming

**Documentation**: See fastedge-debugger/README.md and docs/API.md

### VSCode Extension

IDE integration and helpers:

- Generate launch.json
- Generate mcp.json
- Setup Codespace secrets
- Debugger integration (coming soon)

**Commands**: Open command palette (Ctrl+Shift+P) and search "FastEdge"

---

## Common Tasks: Quick Reference

| Task | Commands/Steps |
|------|----------------|
| **Create app** | Use MCP: `scaffold-fastedge-project` |
| **Install deps** | `cd project && npm install` |
| **Build WASM** | `npm run build` |
| **Start debugger** | `cd fastedge-debugger && npm start` |
| **Test locally** | Load WASM in debugger at http://localhost:5179 |
| **Deploy** | Use MCP: `build-wasm` → `upload-binary` → `update-or-create-app` |
| **Check logs** | Debugger UI or WebSocket at ws://localhost:5178/ws |
| **Set secrets** | CODESPACE_GUIDE.md or use Codespace Secrets panel |

---

## Skills: Your Learning Resources

Skills are **comprehensive, task-specific documentation** that Claude discovers automatically.

### Codespace Skills (Always Available)

1. **codespace-setup** - Ports, configuration, tools
2. **fastedge-quickstart** - Your first FastEdge app

### Project Skills (Added When You Create Projects)

These skills are automatically included when you use `scaffold-fastedge-project`:

1. **fastedge-development** - SDK patterns, error handling, build process
2. **fastedge-debugging** - REST API examples, testing workflows, CI/CD
3. **fastedge-deployment** - MCP tools, deployment patterns, best practices
4. **fastedge-examples** - Links to examples repo, common patterns

**Location**: `.claude/skills/` in each generated project

---

## Reading Strategy

### ✅ Efficient Approach

1. Read **CONTEXT_INDEX.md** (this file) - Get oriented
2. Read **PROJECT_OVERVIEW.md** - Understand the template
3. Based on your task, read **ONE** of:
   - WORKFLOW_GUIDE.md (for development workflow)
   - CODESPACE_GUIDE.md (for Codespace features)
   - Specific skill (for task-specific guidance)
4. Use search and grep for specifics

**Total reading**: ~10-15 minutes to get started, then task-specific docs as needed

### ❌ Inefficient Approach

- ❌ Reading all context files linearly
- ❌ Reading all skills upfront
- ❌ Reading documentation without a specific task in mind
- ❌ Skipping CONTEXT_INDEX.md and getting lost

---

## Search Tips

### Finding Information Quickly

**Use grep to search across documentation:**

```bash
# Search all context files
grep -r "keyword" context/

# Search skills
grep -r "pattern" .claude/skills/

# Search specific file
grep "secret" context/CODESPACE_GUIDE.md
```

**Common searches:**
- Environment variables: `grep -r "env" context/`
- Deployment: `grep -r "deploy" .claude/skills/`
- Testing: `grep -r "debug" context/`
- MCP tools: `grep -r "mcp" context/`

---

## Getting Help

### In This Codespace

- **Skills** - Task-specific guidance in `.claude/skills/`
- **Context** - Documentation in `context/`
- **README files** - In each tool directory

### External Resources

- **FastEdge SDK Docs**: https://g-core.github.io/FastEdge-sdk-js/
- **Examples Repository**: https://github.com/G-Core/FastEdge-examples
- **G-Core Docs**: https://gcore.com/docs/fastedge

### Asking Claude

When asking questions:
1. Be specific about your task
2. Mention relevant skills or docs you've read
3. Include error messages if debugging
4. Claude will reference appropriate context and skills

---

## Summary

**Your Journey:**
1. Start here (CONTEXT_INDEX.md) ✓
2. Understand the template (PROJECT_OVERVIEW.md)
3. Learn the workflow (WORKFLOW_GUIDE.md)
4. Build your app (use MCP + skills)
5. Test locally (fastedge-debugger)
6. Deploy to production (MCP tools)

**Remember:**
- Skills are your primary learning resource
- Follow: Create → Test → Deploy
- Use the decision tree above
- Search, don't read everything

**You're ready to build FastEdge applications! 🚀**

---

**Last Updated**: February 2026
