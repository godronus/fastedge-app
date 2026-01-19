# FastEdge Codespaces Multi-Template Architecture

## Repository Structure

```
fastedge-templates/
├── .github/
│   └── workflows/
│       └── prebuild-all.yml
├── README.md
├── templates/
│   ├── javascript/
│   │   ├── .devcontainer/
│   │   │   ├── devcontainer.json
│   │   │   └── setup.sh
│   │   ├── index.js
│   │   └── package.json
│   ├── rust/
│   │   ├── .devcontainer/
│   │   │   ├── devcontainer.json
│   │   │   └── setup.sh
│   │   ├── src/
│   │   │   └── lib.rs
│   │   └── Cargo.toml
│   ├── typescript/
│   │   ├── .devcontainer/
│   │   │   ├── devcontainer.json
│   │   │   └── setup.sh
│   │   ├── src/
│   │   │   └── index.ts
│   │   ├── package.json
│   │   └── tsconfig.json
│   └── python/
│       ├── .devcontainer/
│       │   ├── devcontainer.json
│       │   └── setup.sh
│       ├── main.py
│       └── requirements.txt
└── .devcontainer/
    └── base/
        └── Dockerfile  # Shared base image
```

## Base Docker Image (Shared)

Create `ghcr.io/yourcompany/fastedge-base:latest` with:

- Node.js 22
- Rust toolchain + wasm32-wasip1 target
- Python 3.11
- FastEdge CLI pre-installed
- Common build tools

## Per-Template devcontainer.json

### Example: JavaScript Template

**templates/javascript/.devcontainer/devcontainer.json:**

```json
{
  "name": "FastEdge JavaScript Template",
  "image": "ghcr.io/yourcompany/fastedge-base:latest",

  "onCreateCommand": "npm install",

  "customizations": {
    "vscode": {
      "extensions": [
        "g-corelabssa.fastedge",
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ],
      "settings": {
        "mcp.servers": {
          "fastedge": {
            "command": "npx",
            "args": ["@gcoredev/fastedge-mcp"]
          }
        }
      }
    },
    "codespaces": {
      "openFiles": ["index.js", "README.md"]
    }
  },

  "forwardPorts": [3000],
  "postAttachCommand": "echo '🚀 Ready to build FastEdge Workers!'"
}
```

### Example: Rust Template

**templates/rust/.devcontainer/devcontainer.json:**

```json
{
  "name": "FastEdge Rust Template",
  "image": "ghcr.io/yourcompany/fastedge-base:latest",

  "onCreateCommand": "rustup target add wasm32-wasip1 && cargo fetch",

  "customizations": {
    "vscode": {
      "extensions": [
        "rust-lang.rust-analyzer",
        "g-corelabssa.fastedge",
        "tamasfe.even-better-toml"
      ],
      "settings": {
        "rust-analyzer.cargo.target": "wasm32-wasip1",
        "mcp.servers": {
          "fastedge": {
            "command": "npx",
            "args": ["@gcoredev/fastedge-mcp"]
          }
        }
      }
    },
    "codespaces": {
      "openFiles": ["src/lib.rs", "Cargo.toml", "README.md"]
    }
  },

  "forwardPorts": [3000],
  "postAttachCommand": "echo '🦀 Ready to build Rust FastEdge Workers!'"
}
```

## Prebuild Configuration

**.github/workflows/prebuild-all.yml:**

```yaml
name: Prebuild All Templates

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  prebuild:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        template: [javascript, rust, typescript, python]
    steps:
      - name: Trigger Codespaces Prebuild
        run: |
          curl -X POST \
            -H "Authorization: Bearer ${{ secrets.GITHUB_TOKEN }}" \
            -H "Accept: application/vnd.github+json" \
            https://api.github.com/repos/${{ github.repository }}/codespaces/prebuild \
            -d '{
              "ref": "${{ github.ref }}",
              "devcontainer_path": ".devcontainer/templates/${{ matrix.template }}/devcontainer.json"
            }'
```

## Website Integration

### HTML Buttons

```html
<div class="templates">
  <a
    href="https://codespaces.new/yourcompany/fastedge-templates?quickstart=1&devcontainer_path=.devcontainer/templates/javascript/devcontainer.json"
    class="btn btn-primary"
  >
    <img src="/icons/javascript.svg" alt="JavaScript" />
    <span>Start with JavaScript</span>
  </a>

  <a
    href="https://codespaces.new/yourcompany/fastedge-templates?quickstart=1&devcontainer_path=.devcontainer/templates/rust/devcontainer.json"
    class="btn btn-primary"
  >
    <img src="/icons/rust.svg" alt="Rust" />
    <span>Start with Rust</span>
  </a>

  <a
    href="https://codespaces.new/yourcompany/fastedge-templates?quickstart=1&devcontainer_path=.devcontainer/templates/typescript/devcontainer.json"
    class="btn btn-primary"
  >
    <img src="/icons/typescript.svg" alt="TypeScript" />
    <span>Start with TypeScript</span>
  </a>
</div>
```

### URL Parameters Explained

- `quickstart=1` - Skips repository creation prompt
- `devcontainer_path=` - Points to specific template's devcontainer
- `ref=branch-name` - Optional: specific branch
- `machine=standardLinux32gb` - Optional: machine size

## Advantages of This Approach

1. **Single Repo** - Easy to maintain all templates
2. **Shared Base Image** - Fast prebuilds (only template-specific items installed per template)
3. **Independent Prebuilds** - Each template prebuild separately
4. **Easy Updates** - Update base image, all templates benefit
5. **Flexible** - Easy to add new templates

## User Experience Flow

1. User visits yourcompany.com/start
2. Clicks "Start with JavaScript"
3. GitHub opens with Codespace creation dialog (or auto-creates)
4. Prebuild loads in ~10-30 seconds
5. VS Code opens with:
   - Template files loaded
   - FastEdge extension active
   - MCP server connected
   - README.md open with instructions
6. User runs `fastedge dev` and starts coding
7. When ready: `fastedge deploy` directly from Codespace

## Cost Optimization

- Free tier: 120 core-hours/month for individuals
- For organization: Prebuilds cost storage + compute
- Estimate: ~$5-10/month for 4 templates with daily prebuilds
- Users only consume compute while actively coding

## Alternative: Codespace Template Links

Create a custom landing page that:

```javascript
// templates-selector.js
function createCodespace(template) {
  const baseUrl = "https://github.com/codespaces/new";
  const params = new URLSearchParams({
    hide_repo_select: "true",
    ref: "main",
    repo: "yourcompany/fastedge-templates",
    devcontainer_path: `.devcontainer/templates/${template}/devcontainer.json`,
    machine: "standardLinux32gb",
  });

  window.location.href = `${baseUrl}?${params.toString()}`;
}
```

## Quick Start for New Template

1. Copy existing template folder
2. Modify devcontainer.json
3. Add template-specific dependencies
4. Update prebuild workflow
5. Add button to website
6. Push to main - prebuild triggers automatically
