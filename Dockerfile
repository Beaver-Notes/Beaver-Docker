FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

ENV DEBIAN_FRONTEND=noninteractive
ARG BEAVER_NOTES_VERSION=4.1.0
ARG DOCKER_IMAGE_VERSION=4.1.0

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget dbus libgtk-3-0 libnss3 libxss1 libasound2 \
    libatk1.0-0 libx11-xcb1 libxcb1 libx11-6 libxext6 \
    libxkbcommon0 libxinerama1 libxcursor1 libwayland-client0 \
    libwayland-server0 libdbus-1-dev libglib2.0-0 libnotify-dev \
    libatk-bridge2.0-0 libgtk2.0-0 libgtk-3-bin python3-xdg chromium chromium-l10n\
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create machine ID for dbus
RUN dbus-uuidgen > /etc/machine-id

# Set working directory
WORKDIR /opt

# Download and install Beaver Notes
RUN \
    ARCH=$(uname -m) && \
    case "$ARCH" in \
    x86_64) DEB_ARCH="amd64" ;; \
    aarch64) DEB_ARCH="arm64" ;; \
    *) echo "Unsupported architecture: $ARCH" && exit 1 ;; \
    esac && \
    wget -q https://github.com/Beaver-Notes/Beaver-Notes/releases/download/${BEAVER_NOTES_VERSION}/Beaver-notes_${BEAVER_NOTES_VERSION}_${DEB_ARCH}.deb && \
    apt-get update && \
    apt-get install -y ./Beaver-notes_${BEAVER_NOTES_VERSION}_${DEB_ARCH}.deb && \
    rm Beaver-notes_${BEAVER_NOTES_VERSION}_${DEB_ARCH}.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# add local files
COPY /rootfs /

# ports and volumes
EXPOSE 3000
VOLUME /config

# Metadata
LABEL \
    org.label-schema.name="beaver-notes" \
    org.label-schema.description="Beaver Notes Dockerized" \
    org.label-schema.version="${DOCKER_IMAGE_VERSION}" \
    org.label-schema.vcs-url="https://github.com/Beaver-Notes/Beaver-Notes" \
    org.label-schema.schema-version="1.0"
