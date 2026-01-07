# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Install required system packages and Terraform
RUN apt-get update && \
    # Install utilities needed for downloading and extracting Terraform
    apt-get install -y wget unzip curl && \
    \
    # Download Terraform binary from HashiCorp official releases
    wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    \
    # Extract the Terraform binary
    unzip terraform_1.6.6_linux_amd64.zip && \
    \
    # Move Terraform binary to a directory in PATH
    mv terraform /usr/local/bin/ && \
    \
    # Clean up the downloaded zip file to reduce image size
    rm terraform_1.6.6_linux_amd64.zip

# Set the working directory inside the container
# All subsequent commands will run from this path
WORKDIR /terraform

# Copy Terraform configuration files from local terraform/ directory
# into the container's working directory
COPY terraform/ /terraform/