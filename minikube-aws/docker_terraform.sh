#!/bin/bash
# -------------------------------------------------------------------------
# Script Name: install_docker_terraform.sh
# Description: Installs Docker Engine and Terraform on RHEL / CentOS systems
# Compatible:  RHEL 8 / 9, CentOS Stream 8 / 9
# -------------------------------------------------------------------------

set -e

echo "🚀 Starting installation of Docker and Terraform on RHEL..."

# -----------------------------
# Update system packages
# -----------------------------
echo "🔄 Updating system packages..."
sudo yum update -y

# -----------------------------
# Install prerequisites
# -----------------------------
echo "📦 Installing prerequisites..."
sudo yum install -y yum-utils curl wget unzip

# -----------------------------
# Remove old Docker versions
# -----------------------------
echo "🧹 Removing any old Docker versions..."
sudo yum remove -y docker \
                 docker-client \
                 docker-client-latest \
                 docker-common \
                 docker-latest \
                 docker-latest-logrotate \
                 docker-logrotate \
                 docker-engine || true

# -----------------------------
# Setup Docker repository
# -----------------------------
echo "🔧 Setting up Docker repository..."
sudo yum-config-manager \
    --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# -----------------------------
# Install Docker
# -----------------------------
echo "🐳 Installing Docker Engine..."
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Enable and start Docker
echo "▶️ Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Verify Docker installation
echo "✅ Docker installed successfully!"
docker --version

# -----------------------------
# Setup Docker permissions
# -----------------------------
if [ $(getent group docker) ]; then
  echo "👥 Adding current user to Docker group..."
  sudo usermod -aG docker $USER
  echo "⚠️  You may need to log out and back in for group changes to take effect."
else
  echo "⚠️  Docker group not found. Skipping usermod."
fi

# -----------------------------
# Install Terraform
# -----------------------------
echo "🌍 Installing Terraform..."

# Add HashiCorp repository
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo

# Install Terraform
sudo yum -y install terraform

# Verify Terraform installation
echo "✅ Terraform installed successfully!"
terraform -version

# -----------------------------
# Completion message
# -----------------------------
echo "🎉 Installation completed successfully!"
echo "You can now use Docker and Terraform on this system."
