# FastEdge DevContainer Configuration

## 🚀 Super Fast Startup (< 30 seconds!)

This devcontainer uses a **pre-built Docker image** that's automatically built and published by GitHub Actions. When you open this repo in a Codespace, it simply pulls the ready-to-use image instead of building from scratch.

### How It Works:

1. **GitHub Action builds the image** (`.github/workflows/build-devcontainer.yml`)
   - Runs on every push to main that changes the Dockerfile
   - Builds and publishes to `ghcr.io/godronus/fastedge-app/devcontainer:latest`
   - Takes ~5 minutes, but only runs once per Dockerfile change

2. **Codespace pulls the image** (instant)
   - No building required
   - All dependencies pre-installed: Rust, Node.js, WASM targets, FastEdge SDK
   - Ready to code in seconds!

### 📦 What's Pre-Installed

The image includes:

- **Node.js 24** with npm
- **Rust toolchain** (minimal profile)
- **WASM targets** (wasm32-wasip1, wasm32-unknown-unknown)
- **Rust tools** (rust-analyzer, rustfmt, clippy)
- **FastEdge SDK** (@gcoredev/fastedge-sdk-js)
- **VS Code extensions** (auto-installed on first open)

### 🔄 Updating the Image

To update the pre-built image:

1. Edit [.devcontainer/Dockerfile](.devcontainer/Dockerfile)
2. Commit and push to main
3. GitHub Action automatically builds and publishes new image
4. Next Codespace startup will use the new image

### 📊 Performance

| Action                               | Time                   |
| ------------------------------------ | ---------------------- |
| First Codespace open                 | ~20-30 seconds         |
| Subsequent opens                     | ~10-15 seconds         |
| Image rebuild (on Dockerfile change) | ~5 minutes (automatic) |

### 🔧 Local Development

To test the devcontainer locally:

```bash
# Rebuild image locally
docker build -t fastedge-dev .devcontainer/

# Or pull the published image
docker pull ghcr.io/godronus/fastedge-app/devcontainer:latest
```
