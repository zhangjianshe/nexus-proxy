# Use a lightweight base image
FROM alpine:latest

# Set arguments for Mihomo (Clash.Meta) version and architecture
# Check https://github.com/MetaCubeX/mihomo/releases for the latest version
ARG MIHOMO_VERSION="v1.19.10" # Example version, always use the latest stable one
ARG TARGET_ARCH="linux-amd64" # Adjust based on Mihomo's release names:
                              # Common options: linux-amd64, linux-arm64, linux-armv7
                              # Check the release assets for the exact naming.

# Install necessary packages
RUN apk update && apk add --no-cache \
    curl \
    unzip \
    tar \
    ca-certificates

# Download and extract Mihomo core
WORKDIR /app
RUN curl -LO "https://github.com/MetaCubeX/mihomo/releases/download/${MIHOMO_VERSION}/mihomo-${TARGET_ARCH}-${MIHOMO_VERSION}.gz" && \
    gunzip "mihomo-${TARGET_ARCH}-${MIHOMO_VERSION}.gz" && \
    mv "mihomo-${TARGET_ARCH}-${MIHOMO_VERSION}" mihomo && \
    chmod +x mihomo

# --- Optional: Add Yacd Dashboard (Highly Recommended for easy management) ---
# Check https://github.com/haishanh/yacd/releases for the latest Yacd version
ARG YACD_VERSION="v0.3.8" # Example version, use latest

# Download and extract Yacd dashboard
WORKDIR /app/public # Default path for Mihomo to serve external UI
RUN curl -LO "https://github.com/haishanh/yacd/releases/download/${YACD_VERSION}/yacd.tar.gz" && \
    tar -xzf yacd.tar.gz -C . && \
    rm yacd.tar.gz

# Create a directory for Mihomo configurations
RUN mkdir -p /config
COPY config.yaml /config/config.yaml
# Expose ports (adjust as per your config.yaml)
# 7890: HTTP/SOCKS5 proxy
# 9090: External Controller API (for dashboard/management)
EXPOSE 7890/tcp 9090/tcp

# Set entrypoint to run Mihomo with external UI
# -d /config: Specifies the configuration directory
# -f config.yaml: Specifies the main configuration file
# -ext-ui /app/public: Tells Mihomo to serve the UI from this directory
ENTRYPOINT ["/app/mihomo", "-d", "/config", "-f", "config.yaml", "-ext-ui", "/app/public"]