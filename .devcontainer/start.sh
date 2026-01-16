#!/bin/bash
# Interactive template selector for FastEdge Apps

echo "╔════════════════════════════════════════════╗"
echo "║   FastEdge Application Template Selector   ║"
echo "╚════════════════════════════════════════════╝"
echo ""
echo "Select a template to get started:"
echo ""
echo "  1) JavaScript/TypeScript Worker"
echo "  2) Rust WASM Worker"
echo "  3) JavaScript with Fetch Handler"
echo "  4) Rust with HTTP Request Handling"
echo "  5) Empty Project (manual setup)"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
  1)
    echo "🚀 Creating JavaScript/TypeScript Worker..."
    mkdir -p my-fastedge-app
    cd my-fastedge-app
    npm init -y
    npm install @gcoredev/fastedge-sdk-js
    cat > index.js << 'EOF'
import { addEventListener } from '@gcoredev/fastedge-sdk-js';

addEventListener('fetch', (event) => {
  event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
  return new Response('Hello from FastEdge!', {
    status: 200,
    headers: { 'Content-Type': 'text/plain' }
  });
}
EOF
    echo "✅ JavaScript template created in ./my-fastedge-app"
    ;;

  2)
    echo "🦀 Creating Rust WASM Worker..."
    cargo new --lib my-fastedge-app
    cd my-fastedge-app
    cat > Cargo.toml << 'EOF'
[package]
name = "my-fastedge-app"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"

[profile.release]
opt-level = "z"
lto = true
EOF
    cat > src/lib.rs << 'EOF'
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn handle_request() -> String {
    "Hello from FastEdge Rust!".to_string()
}
EOF
    echo "✅ Rust template created in ./my-fastedge-app"
    echo "💡 Build with: wasm-pack build --target web"
    ;;

  3)
    echo "🚀 Creating JavaScript Fetch Handler..."
    mkdir -p my-fastedge-app
    cd my-fastedge-app
    npm init -y
    npm install @gcoredev/fastedge-sdk-js
    cat > index.js << 'EOF'
addEventListener('fetch', async (event) => {
  const request = event.request;
  const url = new URL(request.url);

  if (url.pathname === '/api/hello') {
    event.respondWith(
      new Response(JSON.stringify({ message: 'Hello FastEdge!' }), {
        headers: { 'Content-Type': 'application/json' }
      })
    );
  } else {
    event.respondWith(
      new Response('Not Found', { status: 404 })
    );
  }
});
EOF
    echo "✅ Fetch handler template created in ./my-fastedge-app"
    ;;

  4)
    echo "🦀 Creating Rust HTTP Handler..."
    cargo new --lib my-fastedge-app
    cd my-fastedge-app
    cat > Cargo.toml << 'EOF'
[package]
name = "my-fastedge-app"
version = "0.1.0"
edition = "2021"

[lib]
crate-type = ["cdylib"]

[dependencies]
wasm-bindgen = "0.2"
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"

[profile.release]
opt-level = "z"
lto = true
EOF
    cat > src/lib.rs << 'EOF'
use wasm_bindgen::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Serialize)]
struct Response {
    message: String,
    status: u16,
}

#[wasm_bindgen]
pub fn handle_http_request(path: &str) -> String {
    let response = match path {
        "/api/hello" => Response {
            message: "Hello from Rust!".to_string(),
            status: 200,
        },
        _ => Response {
            message: "Not Found".to_string(),
            status: 404,
        },
    };

    serde_json::to_string(&response).unwrap()
}
EOF
    echo "✅ Rust HTTP handler created in ./my-fastedge-app"
    echo "💡 Build with: wasm-pack build --target web"
    ;;

  5)
    echo "📁 Creating empty project..."
    mkdir -p my-fastedge-app
    cd my-fastedge-app
    cat > README.md << 'EOF'
# My FastEdge Application

## Getting Started

Choose your path:

### JavaScript/TypeScript
```bash
npm init -y
npm install @gcoredev/fastedge-sdk-js
```

### Rust
```bash
cargo init --lib
# Add wasm-bindgen to Cargo.toml
```
EOF
    echo "✅ Empty project created in ./my-fastedge-app"
    ;;

  *)
    echo "❌ Invalid choice"
    exit 1
    ;;
esac

echo ""
echo "🎉 Done! Your FastEdge app is ready."
echo "📂 Location: $(pwd)"
