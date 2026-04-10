# Stage 1: Build stage (Alpine)
FROM alpine:latest AS builder

WORKDIR /tmp

# Install wget and tar
RUN apk update && apk add wget tar

# Download and extract SimpleHelp
RUN wget https://simple-help.com/releases/SimpleHelp-linux-amd64.tar.gz && \
    tar -xzf SimpleHelp-linux-amd64.tar.gz && \
    rm SimpleHelp-linux-amd64.tar.gz

# Stage 2: Final image (OpenJDK JRE)
FROM eclipse-temurin:17-jre

WORKDIR /opt

# Install gosu for dropping privileges
RUN apt-get update && apt-get install -y --no-install-recommends gosu && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -ms /bin/bash simplehelpuser

# Copy SimpleHelp from build stage
COPY --from=builder /tmp/SimpleHelp /opt/SimpleHelp

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh /opt/SimpleHelp/serverstart.sh

# Change ownership
RUN chown -R simplehelpuser:simplehelpuser /opt

EXPOSE 8008

ENTRYPOINT ["/entrypoint.sh"]
