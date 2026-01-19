# Two-Stage Image Strategy

This setup uses a **hybrid approach** for maximum performance:

## The Strategy

```
┌─────────────────────────────────────────────────────────────┐
│ 1. BASE IMAGE (built rarely)                                │
│    Dockerfile.base → ghcr.io/.../base:latest                │
│    Contains: Node.js, Rust, WASM targets (heavy, 5+ mins)   │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 2. DEVCONTAINER (built on every .devcontainer change)       │
│    Dockerfile → uses base image (lightweight, 30 sec)       │
│    Contains: Project-specific customizations                │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│ 3. PREBUILD (created by devcontainers/ci)                   │
│    Caches full container state                              │
│    User opens Codespace → 10-20 seconds! ⚡                 │
└─────────────────────────────────────────────────────────────┘
```

## Workflows

### `build-base-image.yml` (runs rarely)

- **Trigger**: When `Dockerfile.base` changes
- **Time**: ~5-7 minutes
- **Purpose**: Build heavy dependencies (Node, Rust, WASM)
- **Output**: `ghcr.io/.../base:latest`

### `build-devcontainer.yml` (runs frequently)

- **Trigger**: When `.devcontainer/` changes
- **Time**: ~1-2 minutes
- **Purpose**: Create Codespaces prebuild using base image
- **Output**: Prebuild for instant Codespace startup

## For End Users

When someone opens your repo in a Codespace:

1. ✅ Base image already exists (built once)
2. ✅ Prebuild already exists (built on push)
3. ⚡ **Codespace ready in 10-20 seconds!**

No building required for users!

## When to Rebuild Base Image

Only rebuild the base image when you need to:

- Upgrade Node.js version
- Add/remove Rust components
- Add system-level dependencies
- Change WASM targets

Everything else goes in the lightweight Dockerfile.

## Manual Rebuild

To manually rebuild the base image:

1. Go to Actions → "Build Base Image"
2. Click "Run workflow"
3. Wait ~5 minutes
4. Next prebuild will use the new base
