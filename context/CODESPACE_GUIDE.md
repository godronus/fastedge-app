# Codespace Guide - FastEdge Template

## What is a GitHub Codespace?

A **GitHub Codespace** is a cloud-based development environment. It's like VSCode in your browser, with everything pre-installed and configured.

**Benefits**:
- Zero local setup
- Consistent environment
- Access from anywhere
- Pre-configured tools

---

## Ports & Services

### Forwarded Ports

GitHub Codespaces automatically forwards ports:

| Port | Service | Access |
|------|---------|--------|
| **5179** | FastEdge Debugger (UI + API) | http://localhost:5179 |
| **5178** | WebSocket logs | ws://localhost:5178/ws |

**How to access**:
1. Click "Ports" tab in VSCode bottom panel
2. Find the port
3. Click globe icon to open in browser
4. Or use "Forward a Port" to add custom ports

### Starting Services

**FastEdge Debugger**:
```bash
cd fastedge-debugger
npm start
```

**MCP Server**:
- Pre-configured in Codespace
- Available to Claude Desktop (if configured)
- No manual start needed

---

## Environment Variables & Secrets

### GitHub Codespace Secrets

**What they are**: Encrypted environment variables available in Codespaces

**How to set**:
1. Go to GitHub Settings → Codespaces
2. Click "New secret"
3. Name: `FASTEDGE_API_KEY`
4. Value: Your FastEdge API key
5. Select repositories

**Access in Codespace**:
```bash
echo $FASTEDGE_API_KEY
```

### .env Files

**For local configuration**:

```bash
# Create .env file
echo "DEBUG=true" >> .env
echo "API_URL=https://staging.api.example.com" >> .env
```

**⚠️ Important**: Never commit `.env` files with secrets!

Add to `.gitignore`:
```
.env
.env.local
```

### Using in Applications

**In FastEdge code**:
```javascript
import { getEnv } from "fastedge::env";

const apiKey = getEnv("FASTEDGE_API_KEY");
const debugMode = getEnv("DEBUG") === "true";
```

**In debugger**:
Set via configuration:
```bash
curl -X POST http://localhost:5179/api/config \
  -H "Content-Type: application/json" \
  -d '{
    "config": {
      "envVars": {
        "FASTEDGE_API_KEY": "your_key_here",
        "DEBUG": "true"
      }
    }
  }'
```

---

## File Persistence

### What Persists

**✅ Persists between sessions**:
- Code you write
- Files you create
- Git commits
- Installed dependencies (if committed)

**❌ Does NOT persist**:
- Running processes
- Temporary files in `/tmp`
- Uncommitted changes (if Codespace is deleted)

### Best Practices

1. **Commit often** - Save your work
2. **Push to remote** - Backup to GitHub
3. **Document setup** - If you install tools, document it

---

## VSCode Extension

### Pre-Installed: FastEdge Launcher

**Commands** (Ctrl+Shift+P):
- `FastEdge (Generate launch.json)` - Create debug config
- `FastEdge (Generate mcp.json)` - Add MCP server
- `FastEdge (Setup Codespace Secrets)` - Configure secrets
- `FastEdge: Start Debugger Server` - Start debugger
- `FastEdge: Stop Debugger Server` - Stop debugger
- `FastEdge: Debug Application` - Debug current app

**Configuration**:
Settings → FastEdge:
- `fastedge.apiUrl` - FastEdge API URL
- `fastedge.debuggerPath` - Path to debugger

---

## MCP Server Configuration

### What is MCP?

**Model Context Protocol** - Standard for AI agents to access tools

**In this Codespace**: Pre-configured FastEdge MCP server provides tools for building and deploying applications.

### Generating mcp.json

**Command**: `FastEdge (Generate mcp.json)`

**Result**: Creates `~/.config/claude-desktop/mcp.json` (or similar)

**Manual setup**:
```json
{
  "mcpServers": {
    "fastedge": {
      "command": "node",
      "args": ["path/to/FastEdge-mcp-server/dist/index.js"],
      "env": {
        "FASTEDGE_API_KEY": "your_key"
      }
    }
  }
}
```

---

## Debugger Integration

### Web UI

**Access**: http://localhost:5179 (after starting)

**Features**:
- Upload WASM files
- Send test requests
- View responses
- Real-time logs
- Environment configuration

### REST API

**Documentation**: See `fastedge-debugger/docs/API.md`

**Quick examples**:
```bash
# Health check
curl http://localhost:5179/health

# Load WASM
curl -X POST http://localhost:5179/api/load \
  -d '{"wasmBase64": "..."}'

# Execute request
curl -X POST http://localhost:5179/api/execute \
  -d '{"url": "http://localhost/", "method": "GET"}'
```

### VSCode Integration (Coming Soon)

Future: Debug applications directly in VSCode with integrated debugger panel.

---

## Git & GitHub

### Committing Changes

**In terminal**:
```bash
git add .
git commit -m "Add my feature"
git push
```

**In VSCode**:
1. Click Source Control icon
2. Stage changes
3. Write commit message
4. Click "Commit" then "Push"

### Creating Pull Requests

**Via CLI** (using `gh`):
```bash
gh pr create --title "My feature" --body "Description"
```

**Via GitHub**:
1. Push changes to branch
2. Go to GitHub repository
3. Click "Compare & pull request"

---

## Customizing the Codespace

### Adding Tools

**System packages**:
Edit `.devcontainer/Dockerfile`:
```dockerfile
RUN apt-get update && apt-get install -y \
    package-name
```

**npm packages**:
```bash
npm install -g package-name

# Document in .devcontainer/start.sh
echo "npm install -g package-name" >> .devcontainer/start.sh
```

### VSCode Settings

**Workspace settings**: `.vscode/settings.json`
```json
{
  "editor.formatOnSave": true,
  "typescript.preferences.importModuleSpecifier": "relative"
}
```

**User settings**: Settings → User
- Available in this Codespace only
- Not committed to repository

---

## Performance Tips

### Faster Builds

1. **Use watch mode**:
   ```bash
   npm run build:watch  # If available
   ```

2. **Cache dependencies**:
   - Commit `package-lock.json`
   - Commit `Cargo.lock` (Rust)

3. **Parallel builds**:
   ```bash
   npm run build &
   npm run test &
   wait
   ```

### Faster Debugger

1. **Keep debugger running**:
   - Don't restart for every test
   - Just reload WASM

2. **Use REST API**:
   - Faster than web UI
   - Scriptable

3. **Batch tests**:
   - Test multiple endpoints at once

---

## Troubleshooting

### Codespace Won't Start

- Check GitHub status
- Try rebuilding container
- Check Dockerfile syntax

### Port Not Accessible

1. Check Ports panel
2. Verify service is running
3. Try manually forwarding port
4. Check firewall settings

### Extension Not Working

1. Reload VSCode window
2. Check extension installed
3. Check extension logs
4. Reinstall extension

### MCP Server Issues

1. Check `FASTEDGE_API_KEY` set
2. Verify mcp.json configuration
3. Check MCP server logs
4. Restart Claude Desktop

### Out of Disk Space

```bash
# Check usage
df -h

# Clean up
npm clean cache --force
rm -rf node_modules
rm -rf */node_modules
```

---

## Tips & Tricks

### Terminal Shortcuts

- **Ctrl+`** - Toggle terminal
- **Ctrl+Shift+`** - New terminal
- **Ctrl+C** - Stop process
- **Ctrl+D** - Exit terminal

### VSCode Shortcuts

- **Ctrl+P** - Quick open file
- **Ctrl+Shift+P** - Command palette
- **Ctrl+B** - Toggle sidebar
- **Ctrl+J** - Toggle panel

### Faster Workflow

1. **Multiple terminals**:
   - Terminal 1: Debugger
   - Terminal 2: Development
   - Terminal 3: Testing

2. **Editor split**:
   - Left: Code
   - Right: Tests or docs

3. **Integrated terminal**:
   - No switching between windows

---

## Resources

### Documentation

- **This Guide**: context/CODESPACE_GUIDE.md
- **Workflow**: context/WORKFLOW_GUIDE.md
- **Skills**: `.claude/skills/`

### External

- **Codespaces Docs**: https://docs.github.com/en/codespaces
- **VSCode Docs**: https://code.visualstudio.com/docs
- **FastEdge Docs**: https://gcore.com/docs/fastedge

---

## Summary

**Your Codespace provides**:
- ✅ Zero-setup development environment
- ✅ Pre-installed tools and dependencies
- ✅ FastEdge debugger for local testing
- ✅ MCP server for deployment
- ✅ VSCode extension for IDE integration
- ✅ Persistent storage for your code

**Remember**:
- Commit often
- Use the debugger
- Set secrets in GitHub settings
- Forward ports for services
- Customize as needed

**You're all set! Start building FastEdge applications. 🚀**

**Last Updated**: February 2026
