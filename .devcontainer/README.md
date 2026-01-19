# FastEdge DevContainer Configuration

## 🚀 Performance Optimizations

This devcontainer has been optimized to reduce build time from **10-15 minutes to ~2-3 minutes** on first build, and **< 30 seconds** on subsequent rebuilds.

### Key Changes Made:

1. **Dockerfile-based build** (instead of `image` + `features`)
   - All heavy installations (Rust targets, wasm-pack, wasmtime, Node packages) are in the Dockerfile
   - Docker layers are cached between builds
   - GitHub Codespaces can prebuild these images

2. **Idempotent setup.sh**
   - Checks if tools are already installed before attempting installation
   - Uses a marker file (`~/.fastedge-setup-complete`) to prevent re-running
   - Only runs on container creation, not on every start

3. **Proper lifecycle commands**
   - `onCreateCommand`: Runs once when container is first created
   - `postCreateCommand`: Installs VS Code extension
   - `updateContentCommand`: Lightweight command when content updates

### 📋 Next Steps to Enable Prebuilds (Optional but Recommended)

To make builds even faster with GitHub Codespaces prebuilds:

1. **Enable prebuilds in your repo settings:**

   ```
   Repository Settings → Codespaces → Set up prebuild
   ```

2. **Configure prebuild triggers:**
   - On push to main branch
   - On a schedule (e.g., daily)

3. **With prebuilds enabled:**
   - First build: Happens in the background after each push
   - Your codespace: Starts in ~30 seconds using the prebuild!

### 🔧 Troubleshooting

If the container still runs setup multiple times:

- Delete `~/.fastedge-setup-complete` to force a fresh setup
- Check the GitHub Codespaces logs for multiple `onCreateCommand` executions

### 📦 What's Installed

The Dockerfile pre-installs:

- Rust toolchain with WASM targets (wasm32-wasip1, wasm32-unknown-unknown)
- wasm-pack (Rust → WASM build tool)
- wasmtime (WASM runtime for local testing)
- @gcoredev/fastedge-sdk-js (FastEdge SDK)
- Node.js, npm, and common utilities

All installations are cached in Docker layers for fast rebuilds.
