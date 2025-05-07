# Use a minimal Ubuntu base image
FROM ubuntu:latest

# Set the working directory inside the container
WORKDIR /app

# Install CA certificates and other required dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libc6 \
    tzdata \
    && rm -rf /var/lib/apt/lists/*

# Copy the binary into the container
COPY bepusdt-linux-amd64 /app/bepusdt

# Copy the config file into the container
COPY conf.toml /app/conf.toml

# Make sure the binary is executable
RUN chmod +x /app/bepusdt

# Set the timezone if needed (optional)
RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# Expose the port that the app uses (8080)
EXPOSE 8080

# Run the binary with the config file when the container starts
CMD ["/app/bepusdt", "-conf", "/app/conf.toml"]
