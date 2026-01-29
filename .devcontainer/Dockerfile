# Debian-based devcontainer with Clang, WASI SDK, Rust, and Node.js
# Optimized for FastEdge WebAssembly development

FROM mcr.microsoft.com/devcontainers/base:debian

ARG DEBIAN_FRONTEND=noninteractive
ARG clang_version=18
ARG wasm32_wasi_version=1.86.0

ENV RUSTUP_HOME=/usr/local/rustup \
  CARGO_HOME=/usr/local/cargo \
  PATH=/usr/local/cargo/bin:$PATH

# Install development dependencies
# Note: git, curl, wget, ca-certificates, gnupg already in base image
RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils python3-pip \
  build-essential dpkg-dev debhelper fakeroot \
  libelf-dev linux-libc-dev gcc-multilib \
  protobuf-compiler protobuf-compiler-grpc libgrpc++-dev \
  libfmt-dev libspdlog-dev libboost-dev libboost-system-dev libyaml-cpp-dev \
  libprotobuf-dev libsystemd-dev pkg-config ragel libpci-dev libnuma-dev \
  python3-paramiko libssl-dev \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Install Clang from Debian repositories
# Debian Trixie has Clang 18+ in default repos
RUN apt-get update && apt-get install -y --no-install-recommends \
  clang-${clang_version} lldb-${clang_version} lld-${clang_version} \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

# Install WASI SDK for WebAssembly compilation
RUN mkdir -p /opt/wasi-sdk \
  && curl -fsSL https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-20/wasi-sdk-20.0-linux.tar.gz \
  | tar -xz -C /opt/wasi-sdk --strip-components=1

# Install Rust with WASM target
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
  | sh -s -- -y --default-toolchain ${wasm32_wasi_version} --profile minimal \
  && rustup target add wasm32-wasip1 \
  && rustup --version && cargo --version && rustc --version

# Set environment variables for WASI SDK
ENV WASI_SYSROOT=/opt/wasi-sdk/share/wasi-sysroot \
  PATH="/opt/wasi-sdk/bin:$PATH" \
  CC=/opt/wasi-sdk/bin/clang \
  CXX=/opt/wasi-sdk/bin/clang++

# Install Node.js v24.12.0 (exact version) using NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
  && apt-get install -y --no-install-recommends nodejs=24.12.0-1nodesource1 \
  && apt-mark hold nodejs \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man \
  && npm install -g pnpm@10.26.2 \
  && node --version && npm --version && pnpm --version

# Configure npm to use user-writable directory for global packages
# This allows vscode user (and Codespace users) to run npm i -g without sudo
RUN mkdir -p /home/vscode/.npm-global \
  && chown -R vscode:vscode /home/vscode/.npm-global

ENV NPM_CONFIG_PREFIX=/home/vscode/.npm-global \
  PATH="/home/vscode/.npm-global/bin:$PATH"
