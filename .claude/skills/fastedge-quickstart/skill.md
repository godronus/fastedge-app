# FastEdge Quickstart Skill

## Overview

This skill guides you through creating, testing, and deploying your first FastEdge application. Follow this step-by-step to build a "Hello World" edge application.

## Prerequisites

- ✅ You're in the FastEdge Codespace
- ✅ Debugger server can be started
- ✅ MCP server is configured
- ✅ FASTEDGE_API_KEY is set (for deployment)

## Your First Application

### Step 1: Create the Application

**Ask Claude**:
```
"Create a new FastEdge HTTP application in JavaScript"
```

**Claude will use MCP**:
- Tool: `scaffold-fastedge-project`
- Template: `http-base`
- Language: `javascript`
- Output: `./my-first-app`

**Result**: Project created with:
```
my-first-app/
├── src/
│   └── index.js          # Your application code
├── .claude/
│   └── skills/           # FastEdge skills
├── package.json          # Dependencies
└── README.md             # Project documentation
```

### Step 2: Explore the Code

**Navigate to project**:
```bash
cd my-first-app
```

**View the code** (`src/index.js`):
```javascript
addEventListener("fetch", (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  return new Response("Hello from FastEdge!", {
    headers: {
      "Content-Type": "text/plain"
    }
  });
}
```

**This code**:
1. Listens for fetch events
2. Responds with "Hello from FastEdge!"
3. Sets content type to plain text

### Step 3: Install Dependencies

```bash
npm install
```

Wait for installation to complete.

### Step 4: Build to WASM

```bash
npm run build
```

**Output**: `dist/app.wasm` (or similar)

**What happened**: Your JavaScript code was compiled to WebAssembly.

### Step 5: Test Locally

**Start the debugger** (in separate terminal):
```bash
# Navigate to debugger
cd ../fastedge-debugger

# Start server
npm start

# Server starts on port 5179
```

**Load your WASM** (back in your project terminal):
```bash
# Get WASM as base64
WASM_BASE64=$(base64 -w 0 ./dist/app.wasm)

# Load into debugger
curl -X POST http://localhost:5179/api/load \
  -H "Content-Type: application/json" \
  -d "{\"wasmBase64\": \"$WASM_BASE64\"}"

# Response: {"ok": true, "wasmType": "http-wasm"}
```

**Send a test request**:
```bash
curl -X POST http://localhost:5179/api/execute \
  -H "Content-Type: application/json" \
  -d '{
    "url": "http://localhost/",
    "method": "GET"
  }'

# Response:
# {
#   "ok": true,
#   "status": 200,
#   "body": "Hello from FastEdge!",
#   "headers": {...}
# }
```

**✅ Success!** Your application works locally.

### Step 6: Deploy to Production

**Ask Claude**:
```
"Deploy my-first-app to FastEdge production"
```

**Claude will use MCP tools**:
1. `build-wasm` - Compile to WASM
2. `upload-binary` - Upload to FastEdge
3. `update-or-create-app` - Create application
4. Returns: Production URL

**Test your deployed app**:
```bash
curl https://my-first-app.fastedge.gcore.io/

# Response: Hello from FastEdge!
```

**🎉 Congratulations!** Your first edge application is live.

## Understanding the Workflow

### Create → Test → Deploy

**Create**: Use MCP to scaffold projects
- Fast setup
- Best practice templates
- Includes skills and documentation

**Test**: Use debugger to test locally
- Faster iteration
- Safe testing
- Real-time logs

**Deploy**: Use MCP to deploy
- Automated process
- Global distribution
- Production-ready

## Next Steps

### Customize Your Application

**Add routing**:
```javascript
async function handleRequest(request) {
  const url = new URL(request.url);

  if (url.pathname === "/hello") {
    return new Response("Hello!");
  }

  if (url.pathname === "/api") {
    return new Response(JSON.stringify({ status: "ok" }), {
      headers: { "Content-Type": "application/json" }
    });
  }

  return new Response("Not Found", { status: 404 });
}
```

**Rebuild and test**:
```bash
npm run build

# Reload in debugger
curl -X POST http://localhost:5179/api/load \
  -d "{\"wasmBase64\": \"$(base64 -w 0 ./dist/app.wasm)\"}"

# Test new endpoints
curl -X POST http://localhost:5179/api/execute \
  -d '{"url": "http://localhost/hello", "method": "GET"}'

curl -X POST http://localhost:5179/api/execute \
  -d '{"url": "http://localhost/api", "method": "GET"}'
```

### Add Environment Variables

**In debugger**:
```bash
curl -X POST http://localhost:5179/api/config \
  -H "Content-Type: application/json" \
  -d '{
    "config": {
      "envVars": {
        "GREETING": "Hello",
        "DEBUG": "true"
      }
    }
  }'
```

**Use in code**:
```javascript
import { getEnv } from "fastedge::env";

async function handleRequest(request) {
  const greeting = getEnv("GREETING") || "Hello";
  return new Response(`${greeting} from FastEdge!`);
}
```

**Rebuild, reload, test**:
```bash
npm run build
# Reload WASM
# Test again
```

### Explore More Templates

**React application**:
```
Ask Claude: "Create a FastEdge React application in TypeScript"

Template: http-react
Language: typescript
Result: Full React app with Vite
```

**Hono backend**:
```
Ask Claude: "Create a FastEdge app with React and Hono backend"

Template: http-react-hono
Language: typescript
Result: React + Hono full-stack app
```

**CDN application**:
```
Ask Claude: "Create a FastEdge CDN application in JavaScript"

Template: cdn-base
Language: javascript
Result: CDN proxy hooks application
```

## Common Patterns

### Pattern: JSON API

```javascript
addEventListener("fetch", (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  const url = new URL(request.url);

  if (url.pathname === "/api/data") {
    const data = {
      message: "Hello from FastEdge!",
      timestamp: Date.now(),
      path: url.pathname
    };

    return new Response(JSON.stringify(data), {
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin": "*"
      }
    });
  }

  return new Response("Not Found", { status: 404 });
}
```

### Pattern: Request Inspection

```javascript
async function handleRequest(request) {
  const url = new URL(request.url);

  const info = {
    method: request.method,
    url: request.url,
    pathname: url.pathname,
    search: url.search,
    headers: Object.fromEntries(request.headers.entries())
  };

  return new Response(JSON.stringify(info, null, 2), {
    headers: { "Content-Type": "application/json" }
  });
}
```

### Pattern: Error Handling

```javascript
async function handleRequest(request) {
  try {
    const url = new URL(request.url);

    if (url.pathname === "/error") {
      throw new Error("Something went wrong!");
    }

    return new Response("Success!");

  } catch (error) {
    console.error("Error:", error);

    return new Response(
      JSON.stringify({
        error: "Internal Server Error",
        message: error.message
      }),
      {
        status: 500,
        headers: { "Content-Type": "application/json" }
      }
    );
  }
}
```

## Tips for Success

### 1. Always Test Locally First

**Don't deploy untested code**:
```
❌ Build → Deploy
✅ Build → Test → Deploy
```

### 2. Use the Debugger Web UI

Visual testing is easier for exploration:
1. Open http://localhost:5179
2. Upload WASM file
3. Configure environment
4. Send requests
5. View responses and logs

### 3. Keep Debugger Running

Leave debugger in separate terminal:
- Terminal 1: Debugger (keep running)
- Terminal 2: Development (edit, build)
- Terminal 3: Testing (curl commands)

### 4. Iterate Quickly

**Fast iteration loop**:
1. Edit code
2. `npm run build`
3. Reload in debugger (don't restart)
4. Test
5. Repeat

### 5. Use Skills

Reference skills for detailed guidance:
- `.claude/skills/fastedge-development/` - SDK patterns
- `.claude/skills/fastedge-debugging/` - Testing workflows
- `.claude/skills/fastedge-deployment/` - Deployment best practices
- `.claude/skills/fastedge-examples/` - Example applications

## Troubleshooting

### Build Fails

**Error**: Syntax error or missing dependency

**Solution**:
```bash
# Check errors
npm run build

# Verify dependencies
npm install

# Check code syntax
# Fix errors and rebuild
```

### WASM Won't Load

**Error**: "Failed to load WASM"

**Solution**:
1. Check WASM file exists: `ls -lh dist/app.wasm`
2. Verify base64 encoding: `base64 -w 0 dist/app.wasm | wc -c`
3. Check debugger is running: `curl http://localhost:5179/health`
4. Try with absolute path

### Test Request Fails

**Error**: "No WASM module loaded"

**Solution**:
1. Load WASM first (step 5)
2. Check WASM loaded: Look for success message
3. Retry request

### Deployment Fails

**Error**: "Failed to upload binary" or "Authentication failed"

**Solution**:
1. Verify FASTEDGE_API_KEY set: `echo $FASTEDGE_API_KEY`
2. Check credentials valid
3. Check network connectivity
4. Retry deployment

## Resources

### Skills (In Your Project)

After creating a project, you'll have:
- `fastedge-development` - Development patterns
- `fastedge-debugging` - Testing guide
- `fastedge-deployment` - Deployment workflows
- `fastedge-examples` - Example code

### Documentation

- **Workflow Guide**: `context/WORKFLOW_GUIDE.md`
- **Codespace Guide**: `context/CODESPACE_GUIDE.md`
- **FastEdge SDK**: https://g-core.github.io/FastEdge-sdk-js/
- **Examples**: https://github.com/G-Core/FastEdge-examples

### Tools

- **Debugger**: http://localhost:5179
- **MCP Server**: Pre-configured in Codespace
- **VSCode Extension**: FastEdge Launcher

## Summary

**You've learned**:
1. ✅ Create a FastEdge application
2. ✅ Build to WebAssembly
3. ✅ Test locally with debugger
4. ✅ Deploy to production
5. ✅ Iterate quickly

**Next**:
- Explore other templates
- Add features to your app
- Learn advanced patterns from skills
- Build something amazing!

**Remember**: Create → Test → Deploy

**You're ready to build edge applications! 🚀**

## Related Skills

- `codespace-setup` - Configure your Codespace
- `fastedge-development` - Advanced development patterns (in projects)
- `fastedge-debugging` - Comprehensive testing guide (in projects)
- `fastedge-deployment` - Production deployment (in projects)
- `fastedge-examples` - Browse examples (in projects)
