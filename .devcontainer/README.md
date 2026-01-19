# FastEdge DevContainer Configuration

## 🚀 Lightning Fast Startup (< 20 seconds!)

This devcontainer uses **GitHub Codespaces Prebuilds** - the optimal solution for 3rd party developers. When anyone opens this repo in a Codespace, GitHub serves a pre-built, ready-to-use container.

### How It Works:

1. **GitHub Action creates prebuild** (`.github/workflows/build-devcontainer.yml`)
   - Runs on every push to main that changes `.devcontainer/`
   - Uses `devcontainers/ci` - GitHub's official prebuild action
   - Builds the Dockerfile AND runs all lifecycle commands
   - Caches the **complete container state** (not just Docker layers)

2. **Codespace uses prebuild** (instant)
   - GitHub automatically detects and uses the prebuild
   - Container is already built, dependencies installed, extensions loaded
   - User gets a working environment in 10-20 seconds!

### Why Prebuilds > Regular Docker Images:

| Approach                           | Speed     | What's Cached        | Codespaces Integration |
| ---------------------------------- | --------- | -------------------- | ---------------------- |
| **Prebuilds** (`devcontainers/ci`) | ⚡ 10-20s | Full container state | ✅ Native              |
| Docker Build/Push                  | 30-60s    | Only Docker layers   | ❌ Manual              |

### 📦 What's Pre-Installed

The prebuild includes:

- **Node.js 24** with npm
- **Rust toolchain** (minimal profile)
- **WASM targets** (wasm32-wasip1, wasm32-unknown-unknown)
- **Rust tools** (rust-analyzer, rustfmt, clippy)
- **FastEdge SDK** (@gcoredev/fastedge-sdk-js)
- **VS Code extensions** (already installed and activated)

### 🔄 Updating the Prebuild

To trigger a new prebuild:

1. Edit files in [.devcontainer/](.devcontainer/)
2. Commit and push to main
3. GitHub Action automatically creates new prebuild (~5 min)
4. Next Codespace will use the updated prebuild

### 📊 Performance for 3rd Party Devs

| Action                   | Time                   |
| ------------------------ | ---------------------- |
| **First Codespace open** | **10-20 seconds** ⚡   |
| Subsequent opens         | 5-10 seconds           |
| Prebuild creation        | ~5 minutes (automatic) |

This is the **fastest possible** experience for developers trying your project!

# Or pull the published image

docker pull ghcr.io/godronus/fastedge-app/devcontainer:latest

```

```
