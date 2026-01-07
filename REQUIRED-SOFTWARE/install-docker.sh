#!/bin/bash
set -e

echo "Updating system..."
sudo apt update -y

echo "Installing Docker via SNAP..."
sudo snap install docker

echo "Starting Docker..."
sudo systemctl enable snap.docker.dockerd
sudo systemctl start snap.docker.dockerd

echo "Adding users to Docker group..."
sudo usermod -aG docker ubuntu
sudo usermod -aG docker jenkins

docker --version
echo "Docker installation completed successfully"
echo "Reboot is required"