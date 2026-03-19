# Codespace Setup Skill

## Overview

This skill covers GitHub Codespace configuration and features specific to FastEdge development. Use this when setting up the environment or troubleshooting Codespace issues.

## Quick Reference

**Ports**:
- 5179: FastEdge Debugger (UI + API)
- 5178: WebSocket logs

**Key Services**:
- FastEdge Debugger: `cd fastedge-debugger && npm start`
- MCP Server: Pre-configured, no manual start needed

**Secrets**: Set in GitHub Settings → Codespaces → Secrets

## Port Forwarding

### Accessing Forwarded Ports

**Method 1: Ports Panel**
1. Click "Ports" tab in VSCode (bottom panel)
2. Find port 5179
3. Click globe icon to open in browser

**Method 2: Manual forwarding**
```bash
# Port is automatically forwarded
# Access at: http://localhost:5179
```

**Method 3: Public access**
1. Right-click port in Ports panel
2. Select "Port Visibility" → "Public"
3. Share the generated URL

### Common Ports

| Port | Service | Purpose |
|------|---------|---------|
| 5179 | Debugger | Web UI + REST API |
| 5178 | WebSocket | Real-time logs |
| 3000 | Custom | Your application (if running locally) |

## Secrets Management

### Setting Secrets

**GitHub Codespace Secrets**:
1. Go to GitHub.com
2. Settings → Codespaces
3. Click "New secret"
4. Name: `FASTEDGE_API_KEY`
5. Value: Your API key
6. Select repository access

**Available in Codespace**:
```bash
# Check if set
echo $FASTEDGE_API_KEY

# Use in scripts
export API_KEY=$FASTEDGE_API_KEY
```

### Local .env Files

**For development**:
```bash
# Create .env
cat > .env << EOF
DEBUG=true
API_URL=https://staging.api.example.com
LOG_LEVEL=verbose
EOF

# ⚠️ Add to .gitignore
echo ".env" >> .gitignore
```

**Loading .env**:
```bash
# Using dotenv in Node.js
npm install dotenv

# In your code
require('dotenv').config();
```

## VSCode Configuration

### Workspace Settings

**Location**: `.vscode/settings.json`

```json
{
  "editor.formatOnSave": true,
  "editor.tabSize": 2,
  "typescript.preferences.importModuleSpecifier": "relative",
  "files.exclude": {
    "**/node_modules": true,
    "**/.git": true
  }
}
```

### User Settings

Access via: Settings → User

These persist across Codespaces but aren't committed.

### Recommended Extensions

**Already installed**:
- FastEdge Launcher (pre-installed)

**Optional**:
- ESLint
- Prettier
- GitLens
- REST Client

## MCP Server Configuration

### Pre-Configured

The MCP server is already set up in this Codespace with:
- FastEdge tools available
- Docker container for builds
- API credentials from secrets

### Generating mcp.json

**For Claude Desktop**:
```
Command: FastEdge (Generate mcp.json)

Creates: ~/.config/claude-desktop/mcp.json
```

**Manual configuration**:
```json
{
  "mcpServers": {
    "fastedge": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-v", "/home/gdoco/dev/gcore/backend/repos/fastedge-coordinator:/workspace",
        "-w", "/workspace/FastEdge-mcp-server",
        "-e", "FASTEDGE_API_KEY=${FASTEDGE_API_KEY}",
        "node:20-alpine",
        "node", "dist/index.js"
      ]
    }
  }
}
```

## Starting Services

### FastEdge Debugger

```bash
# Navigate to debugger
cd /workspace/fastedge-debugger

# Install dependencies (first time)
npm install

# Start server
npm start

# Server starts on port 5179
# Access: http://localhost:5179
```

### Keep Debugger Running

**Tip**: Keep debugger running in a separate terminal:

1. Open new terminal (Ctrl+Shift+`)
2. Start debugger: `cd fastedge-debugger && npm start`
3. Leave it running
4. Use other terminals for development

## File Persistence

### What Persists

✅ **Persists between sessions**:
- All files in workspace
- Installed npm packages (if package.json committed)
- Git commits
- VSCode workspace settings

❌ **Does NOT persist**:
- Running processes (restart services)
- Temporary files (`/tmp`)
- Terminal history
- Uncommitted changes (if Codespace deleted)

### Best Practices

1. **Commit often**: Save your work
2. **Push regularly**: Backup to GitHub
3. **Document setup**: Note any manual installations
4. **Use package.json**: For reproducible dependencies

## Customizing the Environment

### Adding System Packages

Edit `.devcontainer/Dockerfile`:

```dockerfile
# Add to Dockerfile
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    htop
```

Rebuild container:
1. Command Palette (Ctrl+Shift+P)
2. "Codespaces: Rebuild Container"

### Adding npm Packages Globally

```bash
# Install
npm install -g package-name

# Document in start.sh
echo "npm install -g package-name" >> .devcontainer/start.sh
```

### Adding VSCode Extensions

**Method 1**: Extensions panel
- Search and install

**Method 2**: devcontainer.json
```json
{
  "customizations": {
    "vscode": {
      "extensions": [
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ]
    }
  }
}
```

## Troubleshooting

### Port Not Accessible

**Symptom**: Can't access http://localhost:5179

**Solutions**:
1. Check service is running: `ps aux | grep npm`
2. Check Ports panel: Is port listed?
3. Manual forward: Ports → Forward Port → 5179
4. Restart service: Stop and start again

### Service Won't Start

**Symptom**: `npm start` fails

**Solutions**:
1. Check dependencies: `npm install`
2. Check port not in use: `lsof -i :5179`
3. Check logs for errors
4. Try different port: `PORT=5180 npm start`

### Out of Disk Space

**Symptom**: No space left on device

**Solutions**:
```bash
# Check usage
df -h

# Clean npm cache
npm cache clean --force

# Remove node_modules
find . -name "node_modules" -type d -prune -exec rm -rf '{}' +

# Clean Docker (if using)
docker system prune -a
```

### Extension Not Working

**Symptom**: FastEdge extension not responding

**Solutions**:
1. Reload window: Command Palette → "Reload Window"
2. Check extension enabled: Extensions → FastEdge Launcher
3. Check extension logs: Output → FastEdge Launcher
4. Reinstall: Uninstall and install again

### MCP Server Not Found

**Symptom**: Claude can't find MCP tools

**Solutions**:
1. Check mcp.json exists
2. Verify FASTEDGE_API_KEY set
3. Restart Claude Desktop
4. Check MCP server logs
5. Regenerate mcp.json

## Performance Tips

### Faster Builds

1. **Cache dependencies**:
   - Commit lock files
   - Use Docker layer caching

2. **Parallel builds**:
   ```bash
   npm run build & npm run test & wait
   ```

3. **Watch mode**:
   ```bash
   npm run build:watch
   ```

### Faster Testing

1. **Keep debugger running**: Don't restart for each test
2. **Use REST API**: Faster than web UI
3. **Batch requests**: Test multiple endpoints at once
4. **Script tests**: Automate repetitive tests

### Reduce Lag

1. **Close unused terminals**: Free up resources
2. **Close unused editors**: Reduce memory
3. **Restart Codespace**: Fresh start if slow
4. **Use smaller Codespace**: If available

## Tips & Tricks

### Multiple Terminals

**Setup**:
1. Terminal 1: Debugger (keep running)
2. Terminal 2: Development (build, edit)
3. Terminal 3: Testing (run tests)

**Switching**:
- Click terminal name in panel
- Or use dropdown

### Split Editor

**Horizontal split**: Drag editor tab
**Vertical split**: Right-click tab → "Split Right"

**Useful for**:
- Code + tests side-by-side
- Code + documentation
- Multiple files

### Quick Commands

```bash
# Rebuild everything
npm run build:all  # If available

# Clean and rebuild
rm -rf dist && npm run build

# Test after build
npm run build && npm test
```

### Keyboard Shortcuts

**VSCode**:
- Ctrl+P: Quick open file
- Ctrl+Shift+P: Command palette
- Ctrl+`: Toggle terminal
- Ctrl+B: Toggle sidebar

**Terminal**:
- Ctrl+C: Stop process
- Ctrl+D: Exit terminal
- Ctrl+L: Clear terminal

## Integration with Tools

### Debugger Integration

**Start debugger**:
```bash
cd fastedge-debugger && npm start
```

**Access**:
- Web UI: http://localhost:5179
- REST API: http://localhost:5179/api/*
- WebSocket: ws://localhost:5178/ws

### MCP Integration

**Available tools**:
- scaffold-fastedge-project
- build-wasm
- upload-binary
- update-or-create-app
- And more...

**Usage**: Ask Claude to use MCP tools

### Git Integration

**VSCode Source Control**:
1. Make changes
2. Click Source Control icon
3. Stage files
4. Commit
5. Push

**Or use CLI**:
```bash
git add .
git commit -m "Message"
git push
```

## Summary Checklist

When setting up:
- [ ] Verify ports forwarded (5179, 5178)
- [ ] Set FASTEDGE_API_KEY secret
- [ ] Start debugger server
- [ ] Verify MCP server configured
- [ ] Test port access
- [ ] Configure VSCode settings
- [ ] Install additional extensions (if needed)

When working:
- [ ] Keep debugger running
- [ ] Commit code regularly
- [ ] Push to remote backup
- [ ] Use multiple terminals
- [ ] Monitor resource usage

## Related Skills

- `fastedge-quickstart` - Getting started with FastEdge
- `fastedge-debugging` - Using the debugger
- `fastedge-deployment` - Deploying applications

## Resources

- **Codespaces Docs**: https://docs.github.com/en/codespaces
- **Context**: See `context/CODESPACE_GUIDE.md`
- **VSCode**: https://code.visualstudio.com/docs/remote/codespaces
