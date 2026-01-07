# Use Ubuntu 24.04 as the base operating system
FROM ubuntu:24.04

# Update package list and install required tools
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    \
    # Download Terraform binary from HashiCorp
    wget https://releases.hashicorp.com/terraform/1.7.6/terraform_1.7.6_linux_amd64.zip && \
    \
    # Unzip Terraform
    unzip terraform_1.7.6_linux_amd64.zip && \
    \
    # Move Terraform binary to system path
    mv terraform /usr/local/bin/ && \
    \
    # Clean up zip file to keep image small
    rm terraform_1.7.6_linux_amd64.zip

# Set working directory inside container
# Terraform commands will run from here
WORKDIR /terraform
