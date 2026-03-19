# Workflow Guide - FastEdge Development

## The Sacred Workflow: Create → Test → Deploy

**Never skip the testing step.** This workflow ensures safe, efficient development.

---

## Phase 1: Create

### Use MCP to Scaffold Projects

**Tool**: `scaffold-fastedge-project`

**Parameters**:
- `template`: http-base, http-react, http-react-hono, cdn-base
- `language`: javascript, typescript, rust, assemblyscript
- `outputDir`: Where to create the project

**Example**:
```
Ask Claude: "Create a new FastEdge HTTP application in TypeScript"

Claude will use MCP:
- template: http-base
- language: typescript
- outputDir: ./my-app
```

**Result**: Project created with:
- Source code in `src/`
- Build configuration
- `.claude/skills/` directory
- package.json with dependencies

### Install Dependencies

```bash
cd my-app
npm install
```

### Write Your Code

Follow patterns from `.claude/skills/fastedge-development/`:

```javascript
addEventListener("fetch", (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  return new Response("Hello from FastEdge!", {
    headers: { "Content-Type": "text/plain" }
  });
}
```

---

## Phase 2: Test

**⚠️ CRITICAL: Always test locally before deploying**

### Build Your Application

```bash
npm run build
```

Output: `dist/app.wasm` (or similar)

### Start the Debugger

```bash
# In the fastedge-debugger directory
cd ../fastedge-debugger
npm start
```

Debugger starts on port 5179.

### Load WASM

**Option A: Web UI**
1. Open http://localhost:5179
2. Upload your WASM file
3. Configure environment variables if needed

**Option B: REST API**
```bash
WASM_BASE64=$(base64 -w 0 ./dist/app.wasm)

curl -X POST http://localhost:5179/api/load \
  -H "Content-Type: application/json" \
  -d "{\"wasmBase64\": \"$WASM_BASE64\"}"
```

### Send Test Requests

**Via Web UI**: Use the request panel

**Via REST API**:
```bash
curl -X POST http://localhost:5179/api/execute \
  -H "Content-Type: application/json" \
  -d '{
    "url": "http://localhost/",
    "method": "GET"
  }'
```

### Verify Results

- Check response status, headers, body
- Review logs in debugger UI
- Test error cases
- Test with different inputs

### Iterate

If tests fail:
1. Fix the code
2. Rebuild: `npm run build`
3. Reload WASM in debugger
4. Test again

**Repeat until all tests pass.**

---

## Phase 3: Deploy

### Prerequisites

- ✅ Tests pass in debugger
- ✅ All endpoints work
- ✅ Error handling tested
- ✅ Environment variables configured

### Deployment via MCP

**Step 1: Build WASM**

Tool: `build-wasm`

```
Ask Claude: "Build my FastEdge application to WASM"

Parameters:
- source_path: ./src/index.js (or .ts)
- output_path: ./dist/app.wasm
- language: javascript (or typescript)
```

**Step 2: Upload Binary**

Tool: `upload-binary`

```
Ask Claude: "Upload the WASM binary to FastEdge"

Parameters:
- wasm_path: ./dist/app.wasm
- app_name: my-edge-app (optional)

Returns: binary_id
```

**Step 3: Create/Update Application**

Tool: `update-or-create-app`

```
Ask Claude: "Deploy the application to FastEdge"

Parameters:
- app_name: my-edge-app
- binary_id: [from step 2]
- client_id: [your client ID]
- status: active

Returns: app_id, url
```

**Step 4: Configure Environment Variables**

Tool: `update-env-vars-app`

```
Ask Claude: "Set environment variables for my app"

Parameters:
- app_id: [from step 3]
- env_vars: {
    "DEBUG": "false",
    "API_URL": "https://api.production.com"
  }
```

### Verify Deployment

Test the deployed URL:

```bash
curl https://my-edge-app.fastedge.gcore.io/
```

Check:
- Application responds correctly
- All endpoints work
- Environment variables are set
- Error handling works

### Rollback if Needed

If deployment fails:
1. Use previous binary_id
2. Update application with old binary
3. Fix issues locally
4. Test with debugger
5. Redeploy when ready

---

## Complete Example Workflow

### Scenario: Create and Deploy HTTP API

**Step 1: Create**
```
Human: "Create a FastEdge TypeScript HTTP application that returns JSON"

Claude uses MCP: scaffold-fastedge-project
  template: http-base
  language: typescript
  outputDir: ./my-json-api
```

**Step 2: Develop**
```bash
cd my-json-api
npm install

# Edit src/index.ts
addEventListener("fetch", (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request: Request): Promise<Response> {
  const url = new URL(request.url);

  if (url.pathname === "/api/data") {
    return new Response(JSON.stringify({ message: "Hello, FastEdge!" }), {
      headers: { "Content-Type": "application/json" }
    });
  }

  return new Response("Not Found", { status: 404 });
}

# Build
npm run build
```

**Step 3: Test**
```bash
# Start debugger
cd ../fastedge-debugger && npm start

# Load WASM
curl -X POST http://localhost:5179/api/load \
  -H "Content-Type: application/json" \
  -d "{\"wasmBase64\": \"$(base64 -w 0 ../my-json-api/dist/app.wasm)\"}"

# Test endpoint
curl -X POST http://localhost:5179/api/execute \
  -H "Content-Type: application/json" \
  -d '{"url": "http://localhost/api/data", "method": "GET"}'

# Response: {"message": "Hello, FastEdge!"}
```

**Step 4: Deploy**
```
Human: "Deploy my-json-api to FastEdge"

Claude uses MCP tools:
1. build-wasm → WASM compiled
2. upload-binary → binary_id returned
3. update-or-create-app → app deployed
4. Returns: https://my-json-api.fastedge.gcore.io
```

**Step 5: Verify**
```bash
curl https://my-json-api.fastedge.gcore.io/api/data
# Response: {"message": "Hello, FastEdge!"}
```

---

## Common Patterns

### Pattern: Environment Variables

**Development** (in debugger):
```json
{
  "envVars": {
    "DEBUG": "true",
    "API_URL": "https://staging.api.example.com"
  }
}
```

**Production** (via MCP):
```
update-env-vars-app:
  app_id: app_123
  env_vars:
    DEBUG: "false"
    API_URL: "https://api.example.com"
```

### Pattern: Testing Before Deploy

```bash
#!/bin/bash
# test-and-deploy.sh

# Build
echo "Building..."
npm run build || exit 1

# Test
echo "Testing..."
WASM_BASE64=$(base64 -w 0 ./dist/app.wasm)
curl -X POST http://localhost:5179/api/load \
  -d "{\"wasmBase64\": \"$WASM_BASE64\"}" || exit 1

# Run tests
./run-tests.sh || exit 1

# Deploy only if tests pass
echo "Tests passed! Deploying..."
# Use MCP tools to deploy
```

### Pattern: Incremental Updates

1. Make small changes
2. Test each change
3. Deploy incrementally
4. Monitor production
5. Rollback if issues

---

## Tips & Best Practices

### Development

1. **Start small** - Build incrementally
2. **Test often** - Every change should be tested
3. **Use skills** - Follow patterns from `.claude/skills/`
4. **Log everything** - Use console.log for debugging
5. **Handle errors** - Proper error responses

### Testing

1. **Test all endpoints** - Don't skip any
2. **Test error cases** - Invalid inputs, missing params
3. **Test edge cases** - Empty body, special characters
4. **Test performance** - Response times
5. **Test configuration** - Different env vars

### Deployment

1. **Deploy to staging first** - If available
2. **Monitor closely** - First 24 hours critical
3. **Have rollback plan** - Keep previous binary_id
4. **Document changes** - What was deployed
5. **Verify in production** - Test deployed URL

---

## Troubleshooting

### Build Fails

- Check syntax errors
- Verify dependencies installed
- Check build configuration
- See compiler output

### Tests Fail

- Check debugger logs
- Verify WASM loaded correctly
- Check environment variables
- Test with simple request first

### Deployment Fails

- Verify credentials set
- Check binary_id valid
- Verify client_id correct
- Check MCP server logs

### Application Not Responding

- Check application status (should be "active")
- Verify correct binary_id deployed
- Check environment variables set
- Test locally with same binary

---

## Summary Checklist

Before deploying to production:

- [ ] Code written following best practices
- [ ] Application builds without errors
- [ ] All endpoints tested in debugger
- [ ] Error handling tested
- [ ] Environment variables configured
- [ ] Edge cases tested
- [ ] Performance acceptable
- [ ] Rollback plan ready

**If all checks pass → Deploy!**

---

**Remember: Create → Test → Deploy. Never skip testing.**

**Last Updated**: February 2026
