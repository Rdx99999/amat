# Use the official Ubuntu base image
FROM ubuntu:22.04

# Install necessary packages
RUN apt update && apt install -y wget tar

# Set FRP version
ENV FRP_VERSION=0.52.1

# Download and extract FRP
RUN wget https://github.com/fatedier/frp/releases/download/v$FRP_VERSION/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar -xvzf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64 /frp \
    && rm frp_${FRP_VERSION}_linux_amd64.tar.gz

# Copy the configuration file
COPY frps.ini /frp/frps.ini

# Expose necessary ports
EXPOSE 7000 7500

# Run the FRP server
CMD ["/frp/frps", "-c", "/frp/frps.ini"]
