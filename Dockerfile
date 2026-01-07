FROM ubuntu:24.04

# Install required packages
RUN apt-get update && \
    apt-get install -y wget unzip curl && \
    wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    unzip terraform_1.6.6_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.6.6_linux_amd64.zip

# Set working directory
WORKDIR /terraform

# Copy terraform code INTO image
COPY terraform/ /terraform/