FROM ubuntu:24.04

# Install required tools
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    \
    # Download a VALID Terraform version
    wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    \
    # Unzip Terraform
    unzip terraform_1.6.6_linux_amd64.zip && \
    \
    # Move Terraform binary to PATH
    mv terraform /usr/local/bin/ && \
    \
    # Cleanup
    rm terraform_1.6.6_linux_amd64.zip

# Set working directory
WORKDIR /terraform