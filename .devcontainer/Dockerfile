FROM mcr.microsoft.com/devcontainers/base:ubuntu
# Install the necessary packages
RUN apt-get update && apt-get install -y curl mosquitto-clients
COPY ["./hono*", "./"]