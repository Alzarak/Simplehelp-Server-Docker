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
FROM openjdk:17-jdk-slim

WORKDIR /opt

# Create non-root user
RUN useradd -ms /bin/bash simplehelpuser

# Copy SimpleHelp from build stage
COPY --from=builder /tmp/SimpleHelp /opt/SimpleHelp

# Change ownership
RUN chown -R simplehelpuser:simplehelpuser /opt

USER simplehelpuser

RUN chmod +x /opt/SimpleHelp/serverstart.sh

EXPOSE 8008

ENTRYPOINT ["/bin/sh", "-c", "/opt/SimpleHelp/serverstart.sh && tail -f /dev/null"]
