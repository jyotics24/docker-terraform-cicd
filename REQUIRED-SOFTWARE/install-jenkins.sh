#!/bin/bash
# Install Java 21 and Jenkins
# Safe upgrade-ready version

set -e

echo "Updating system..."
sudo apt update -y
sudo apt upgrade -y

echo "Installing OpenJDK 21..."
sudo apt install -y openjdk-21-jdk

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Set JAVA_HOME for current session
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
export PATH=$JAVA_HOME/bin:$PATH
echo "JAVA_HOME set to $JAVA_HOME"

echo "Adding Jenkins GPG key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "Adding Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
/etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Installing Jenkins..."
sudo apt update -y
sudo apt install -y jenkins

# Ensure Jenkins uses Java 21 permanently
echo "Configuring Jenkins to use Java 21..."
sudo sed -i "s|^JAVA_HOME=.*|JAVA_HOME=$JAVA_HOME|" /etc/default/jenkins || echo "JAVA_HOME=$JAVA_HOME" | sudo tee -a /etc/default/jenkins

echo "Starting Jenkins..."
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# Verify installations
echo "Java version:"
java -version
echo "Jenkins version:"
jenkins --version
