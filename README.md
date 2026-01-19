# FastEdge Apps Dev Container

A preconfigured VS Code Dev Container / Codespace for developing WebAssembly-based FastEdge applications.

## 🚀 Quick Start

### Local Development (Recommended for testing)

1. **Prerequisites**
   - Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
   - Install [VS Code](https://code.visualstudio.com/)
   - Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Open in Container**
   - Open this folder in VS Code
   - Press `F1` → **"Dev Containers: Reopen in Container"**
   - Wait for the container to build (first time takes ~5 minutes)

3. **Create Your First App**
   ```bash
   bash .devcontainer/start.sh
   ```

### GitHub Codespaces (Cloud)

Once you've tested locally:

1. Push this repo to GitHub
2. Click "Code" → "Codespaces" → "Create codespace on main"
3. Your dev environment will be ready in the cloud!

## 🛠️ What's Included

- **Rust** (latest) with WASM targets
  - `wasm32-wasip1` - WASI preview 1
- **Node.js** v22 with npm
- **FastEdge SDK** (`@gcoredev/fastedge-sdk-js`)
- **VS Code Extensions**
  - Rust Analyzer
  - FastEdge extension
  - TOML support
  - ESLint & Prettier

## 📝 Development Workflow

### Iterating on the Dev Container

1. Edit `.devcontainer/devcontainer.json` or `.devcontainer/setup.sh`
2. Press `F1` → **"Dev Containers: Rebuild Container"**
3. Test your changes
4. Repeat until satisfied

### Building WASM Apps

**JavaScript/TypeScript:**

```bash
npm install @gcoredev/fastedge-sdk-js
# Write your code
# Deploy to FastEdge
```

**Rust:**

```bash
cargo new --lib my-app
cd my-app
# Edit Cargo.toml and src/lib.rs
wasm-pack build --target web
# Deploy the generated WASM
```

## 🎯 Template Options

The interactive starter (`bash .devcontainer/start.sh`) provides:

1. **JavaScript/TypeScript Worker** - Basic event listener
2. **Rust WASM Worker** - Minimal Rust WASM setup
3. **JavaScript Fetch Handler** - HTTP request routing
4. **Rust HTTP Handler** - Rust-based HTTP handling
5. **Empty Project** - Start from scratch

## 🐛 Testing Locally

```bash
# Test Rust WASM compilation
cargo build --target wasm32-wasip1

# Run WASM locally
wasmtime run target/wasm32-wasip1/debug/my-app.wasm

# Check installed tools
rustc --version
node --version
wasm-pack --version
```

## 📚 Resources

- [FastEdge Documentation](https://gcore.com/docs/fastedge)
- [Cloudflare Workers Docs](https://developers.cloudflare.com/workers/) (similar concepts)
- [Rust WASM Book](https://rustwasm.github.io/docs/book/)
- [WASI Preview 1](https://github.com/WebAssembly/WASI)

## 🔧 Customization

Edit `.devcontainer/devcontainer.json` to:

- Add more VS Code extensions
- Install additional tools
- Configure port forwarding
- Set environment variables

Edit `.devcontainer/setup.sh` to:

- Add custom build tools
- Pre-install dependencies
- Configure shell environment

## 💡 Tips

- **Fast Rebuilds**: Only features/tools in `postCreateCommand` need rebuild
- **Caching**: Docker layers cache dependencies between builds
- **Debugging**: Check terminal output during "Starting Dev Container"
- **Shell**: Open integrated terminal (`` Ctrl+` ``) for commands

## 🚢 Publishing to GitHub

When ready to share:

```bash
git init
git add .
git commit -m "Initial FastEdge dev container"
git remote add origin <your-repo-url>
git push -u origin main
```

Now anyone can use your Codespace template!
