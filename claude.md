# AI Agent Instructions for FastEdge Codespace Template

## 🎯 CRITICAL: Read Smart, Not Everything

**DO NOT read all context files upfront.** This repository uses a **discovery-based context system** to minimize token usage while maximizing effectiveness.

---

## Getting Started: Discovery Pattern

### Step 1: Read the Index (REQUIRED - ~100 lines)

**First action when starting work**: Read `context/CONTEXT_INDEX.md`

This lightweight file (~100 lines) gives you:
- Quick start guide for this Codespace
- Documentation map organized by topic
- Decision tree for what to read when
- Links to skills for FastEdge development

### Step 2: Read Based on Your Task (JUST-IN-TIME)

Use the decision tree in CONTEXT_INDEX.md to determine what to read. **Only read what's relevant to your current task.**

**Examples:**

**Task: "Create a new FastEdge application"**
- Read: `.claude/skills/fastedge-development/` - Core patterns
- Read: `context/WORKFLOW_GUIDE.md` - Create → Test → Deploy workflow
- Use MCP tool: `scaffold-fastedge-project`

**Task: "Test the application locally"**
- Read: `.claude/skills/fastedge-debugging/` - How to use debugger
- Read: `context/WORKFLOW_GUIDE.md` - Testing section
- Start debugger server and test

**Task: "Deploy to production"**
- Read: `.claude/skills/fastedge-deployment/` - Deployment via MCP
- Read: `context/WORKFLOW_GUIDE.md` - Deployment section
- Use MCP tools: `build-wasm`, `upload-binary`, `update-or-create-app`

**Task: "Understand Codespace features"**
- Read: `context/CODESPACE_GUIDE.md` - Codespace-specific features
- Read: `context/PROJECT_OVERVIEW.md` - What is this template
- Explore `.devcontainer/` configuration

### Step 3: Discover Skills

**Skills are your primary learning resource.** They provide comprehensive, task-specific guidance:

- **`.claude/skills/codespace-setup/`** - Codespace configuration and features
- **`.claude/skills/fastedge-quickstart/`** - Getting started with FastEdge
- **`.claude/skills/fastedge-development/`** - Build FastEdge apps (created with project)
- **`.claude/skills/fastedge-debugging/`** - Test locally (created with project)
- **`.claude/skills/fastedge-deployment/`** - Deploy to production (created with project)
- **`.claude/skills/fastedge-examples/`** - Browse examples (created with project)

Skills are automatically loaded when relevant to your current task. You can also reference them directly.

---

## 📋 Decision Tree Reference

**Quick lookup for common tasks:**

| Task Type | What to Use |
|-----------|-------------|
| **Create new app** | MCP: `scaffold-fastedge-project` + skill: fastedge-development |
| **Test locally** | Start debugger + skill: fastedge-debugging |
| **Deploy to prod** | MCP tools + skill: fastedge-deployment |
| **Fix a bug** | Read code + skill: fastedge-development + test with debugger |
| **Add a feature** | skill: fastedge-development + skill: fastedge-examples |
| **Understand Codespace** | context/CODESPACE_GUIDE.md + skill: codespace-setup |
| **Learn workflow** | context/WORKFLOW_GUIDE.md |

---

## 🚀 Quick Start Workflow

### Complete Development Workflow

1. **Create** - Scaffold a new FastEdge project
   ```
   Use MCP tool: scaffold-fastedge-project
   Choose template and language
   ```

2. **Develop** - Write your application code
   ```
   Follow patterns from fastedge-development skill
   Use JavaScript/TypeScript SDK
   Implement fetch event listener
   ```

3. **Test** - Test locally before deploying
   ```
   Build: npm run build
   Start debugger: npm start (in fastedge-debugger)
   Test via REST API or web UI
   See fastedge-debugging skill for details
   ```

4. **Deploy** - Deploy to production
   ```
   Use MCP tools:
   - build-wasm
   - upload-binary
   - update-or-create-app
   See fastedge-deployment skill for details
   ```

---

## 🎯 This Codespace Provides

### Pre-Installed Tools

- **FastEdge MCP Server** - Build, deploy, scaffold applications
- **fastedge-debugger** - Local testing runtime
- **VSCode Extension** - IDE integration and helpers
- **Node.js, Rust, toolchains** - All build dependencies

### Available Resources

- **MCP Tools** - Access via Claude Desktop or API
  - `scaffold-fastedge-project` - Create new projects
  - `build-wasm` - Compile to WebAssembly
  - `upload-binary` - Upload to FastEdge
  - `update-or-create-app` - Deploy applications
  - And more (see FastEdge-mcp-server)

- **Debugger Server** - Port 5179
  - Web UI for manual testing
  - REST API for agent automation
  - Real-time log streaming

- **Skills** - Task-specific guidance
  - Automatically discovered by Claude
  - Comprehensive documentation
  - Code examples and patterns

### Configuration Files

- `.devcontainer/` - Codespace configuration
- `start.sh` - Initialization script
- `mcp.json` - MCP server configuration (if generated)

---

## 🔧 Codespace-Specific Tips

### Starting the Debugger

```bash
# In the fastedge-debugger directory
cd fastedge-debugger
npm start
```

Access at: `http://localhost:5179`

### Using MCP Tools

MCP tools are available when Claude Desktop is configured with the MCP server. The server runs in this Codespace and provides tools for building and deploying FastEdge applications.

### Port Forwarding

GitHub Codespaces automatically forwards ports:
- **5179** - FastEdge Debugger (web UI + REST API)
- **5178** - WebSocket logs (optional)

Access forwarded ports via the Ports panel in VSCode.

### Environment Variables

Set FastEdge credentials:
```bash
# In .env or Codespace secrets
FASTEDGE_API_KEY=your_api_key
```

See `context/CODESPACE_GUIDE.md` for details on managing secrets.

---

## 📁 Context Organization

The context folder is organized by topic:

```
context/
├── CONTEXT_INDEX.md          # Read this first (100 lines)
├── PROJECT_OVERVIEW.md       # What is this template
├── CODESPACE_GUIDE.md        # Codespace features
└── WORKFLOW_GUIDE.md         # Create → Test → Deploy
```

The skills folder provides task-specific guidance:

```
.claude/skills/
├── codespace-setup/          # Codespace configuration
├── fastedge-quickstart/      # Getting started
└── [more skills added when creating projects]
```

---

## 🚫 Anti-Patterns (What NOT to Do)

❌ **Don't**: Read all docs upfront (wastes tokens)
❌ **Don't**: Skip testing locally before deploying
❌ **Don't**: Ignore skills - they contain critical patterns
❌ **Don't**: Deploy without using the debugger first
❌ **Don't**: Hardcode credentials in code (use env vars)

✅ **Do**: Read CONTEXT_INDEX.md first
✅ **Do**: Use skills for task-specific guidance
✅ **Do**: Test with debugger before deploying
✅ **Do**: Follow the Create → Test → Deploy workflow
✅ **Do**: Use MCP tools for deployment

---

## ⚡ Critical Working Practices

### Task Checklists (ALWAYS USE)

When starting any non-trivial task (multi-step, features, deployment, etc.):

1. **First action**: Use TaskCreate to break down the work into trackable tasks
2. Update task status as you work (`in_progress` → `completed`)
3. This gives the user real-time visibility into progress

**When to create task checklists:**
- Creating a new application
- Adding features
- Deployment workflows
- Multi-step testing

### The Workflow is Sacred

**ALWAYS follow: Create → Test → Deploy**

Never skip the testing step. The debugger is there for a reason:
1. **Faster iteration** - No deployment wait time
2. **Safe testing** - No impact on production
3. **Better debugging** - Real-time logs
4. **Cost effective** - No edge compute costs during development

### Use Skills Proactively

Skills contain patterns, examples, and best practices. Reference them often:
- Before starting work: Check relevant skill
- During development: Follow skill patterns
- When stuck: Re-read skill for guidance
- After completion: Verify against skill checklist

---

## 📝 Common Workflows

### Workflow 1: Create and Deploy Simple HTTP App

```
1. Read: fastedge-development skill
2. Use MCP: scaffold-fastedge-project
   - Template: http-base
   - Language: javascript or typescript
3. cd into project directory
4. npm install
5. Write code in src/index.js
6. npm run build
7. Test with debugger:
   - Start debugger: cd ../fastedge-debugger && npm start
   - Load WASM via API
   - Send test requests
8. Deploy via MCP:
   - build-wasm
   - upload-binary
   - update-or-create-app
```

### Workflow 2: Debug an Existing Application

```
1. Read: fastedge-debugging skill
2. Build application: npm run build
3. Start debugger: cd ../fastedge-debugger && npm start
4. Load WASM via REST API or web UI
5. Configure environment variables if needed
6. Send test requests
7. Check logs for errors
8. Fix issues, rebuild, reload
9. Repeat until tests pass
```

### Workflow 3: Explore Examples

```
1. Read: fastedge-examples skill
2. Browse examples repo: https://github.com/G-Core/FastEdge-examples
3. Find relevant pattern (API proxy, caching, etc.)
4. Copy pattern to your project
5. Adapt for your use case
6. Test with debugger
7. Deploy when ready
```

---

## 🎓 Learning Resources

### Documentation

- **FastEdge SDK**: https://g-core.github.io/FastEdge-sdk-js/
- **Examples Repo**: https://github.com/G-Core/FastEdge-examples
- **MCP Server**: See FastEdge-mcp-server README
- **Debugger**: See fastedge-debugger README and docs/API.md

### Skills (In This Codespace)

- All skills in `.claude/skills/` directory
- Automatically discovered by Claude
- Updated when you create projects

### Context Files

- Start with `context/CONTEXT_INDEX.md`
- Read specific docs based on task
- Follow links to related documentation

---

## 🚀 Getting Started Checklist

On your first task:

- [ ] Read `context/CONTEXT_INDEX.md`
- [ ] Read `context/PROJECT_OVERVIEW.md` (quick overview)
- [ ] Read `context/WORKFLOW_GUIDE.md` (understand workflows)
- [ ] Browse `.claude/skills/` (see available guidance)
- [ ] Try creating a simple app (MCP: scaffold-fastedge-project)
- [ ] Test it with the debugger
- [ ] Deploy it via MCP

---

## Summary: How to Work Efficiently

1. **Read `context/CONTEXT_INDEX.md` first** (~100 lines)
2. **Use skills for task-specific guidance** (comprehensive patterns)
3. **Follow the workflow**: Create → Test → Deploy
4. **Test locally before deploying** (always use debugger)
5. **Use MCP tools for deployment** (automated workflows)
6. **Create task checklists** for non-trivial work
7. **Update documentation** after significant changes

**Token Savings**: 75-80% reduction vs. reading all docs upfront

**Result**: Fast agent startup, better focus, efficient "vibe coding" experience

---

**Welcome to FastEdge Codespace! Let's build something amazing. 🚀**

**Last Updated**: February 2026
