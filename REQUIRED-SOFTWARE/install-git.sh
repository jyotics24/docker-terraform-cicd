#!/bin/bash
# Install Git

set -e

echo "Updating system..."
sudo apt update -y

echo "Installing Git..."
sudo apt install -y git

git --version
echo "Git installation completed "
