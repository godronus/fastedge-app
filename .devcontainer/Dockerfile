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

# Install Node.js v24 (multi-architecture support)
RUN apt-get update && apt-get install -y --no-install-recommends xz-utils \
  && ARCH=$(dpkg --print-architecture) \
  && case "$ARCH" in \
       amd64) NODE_ARCH="x64" ;; \
       arm64) NODE_ARCH="arm64" ;; \
       *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
     esac \
  && curl -fsSL https://nodejs.org/dist/v24.12.0/node-v24.12.0-linux-${NODE_ARCH}.tar.xz -o node.tar.xz \
  && curl -fsSL https://nodejs.org/dist/v24.12.0/SHASUMS256.txt -o SHASUMS256.txt \
  && grep "node-v24.12.0-linux-${NODE_ARCH}.tar.xz" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf node.tar.xz -C /usr/local --strip-components=1 \
  && rm node.tar.xz SHASUMS256.txt \
  && apt-get purge --auto-remove -y xz-utils \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man /tmp/* \
  && npm install -g pnpm@10.26.2 \
  && node --version && npm --version && pnpm --version
