# Use a lightweight base image
FROM alpine:latest

# Set arguments for Clash version, architecture, and Yacd version
ARG CLASH_VERSION="1.18.0" # Check https://github.com/Dreamacro/clash/releases for the latest version
ARG TARGET_ARCH="amd64"    # Change this to your architecture: amd64, arm64, armv7, 386 etc.
ARG YACD_VERSION="v0.3.8"  # Check https://github.com/haishanh/yacd/releases for the latest version

# Install necessary packages
RUN apk update && apk add --no-cache \
    curl \
    unzip \
    tar \
    ca-certificates

# Download and extract Clash core
WORKDIR /app
RUN curl -LO "https://github.com/Dreamacro/clash/releases/download/v${CLASH_VERSION}/clash-linux-${TARGET_ARCH}-v${CLASH_VERSION}.gz" && \
    gunzip "clash-linux-${TARGET_ARCH}-v${CLASH_VERSION}.gz" && \
    mv "clash-linux-${TARGET_ARCH}-v${CLASH_VERSION}" clash && \
    chmod +x clash

# Download and extract Yacd dashboard
WORKDIR /app/public # Default path for Clash to serve external UI
RUN curl -LO "https://github.com/haishanh/yacd/releases/download/${YACD_VERSION}/yacd.tar.gz" && \
    tar -xzf yacd.tar.gz -C . && \
    rm yacd.tar.gz

# Create a directory for Clash configurations
RUN mkdir -p /config

# Expose ports
# 7890: HTTP/SOCKS5 proxy
# 9090: External Controller API and Web UI (Yacd)
EXPOSE 7890/tcp 9090/tcp

# Set entrypoint to run Clash with external UI
# -d /config: Specifies the configuration directory
# -f config.yaml: Specifies the main configuration file
# -ext-ui /app/public: Tells Clash to serve the UI from this directory
ENTRYPOINT ["/app/clash", "-d", "/config", "-f", "config.yaml", "-ext-ui", "/app/public"]