#!/bin/bash

# Update packages
sudo apt update -y && sudo apt upgrade -y

# Install required dependencies
sudo apt install -y \
  build-essential \
  curl \
  git \
  htop \
  jq \
  nano \
  tree \
  unzip \
  vim \
  wget \
  zip

# Install Go
if ! command -v go &> /dev/null; then
  echo "Installing Go..."
  # Detect system architecture
  arch=$(uname -m)
  if [[ "$arch" == "x86_64" ]]; then
    # Download amd64 version for Linux machines
    wget -q "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz"
    go_arch="amd64"
  elif [[ "$arch" == "arm64" ]] || [[ "$arch" == "aarch64" ]]; then
    # Download arm64 version for Macs M1/M2 and other arm64 architectures
    wget -q "https://go.dev/dl/go${GO_VERSION}.linux-arm64.tar.gz"
    go_arch="arm64"
  else
    echo "Unsupported architecture: $arch"
    exit 1
  fi

  sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "go${GO_VERSION}.linux-${go_arch}.tar.gz"
  rm "go${GO_VERSION}.linux-${go_arch}.tar.gz"
fi

# Add Go in PATH
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
source /etc/profile
# Configure GOPATH
touch /home/vagrant/.bash_profile
echo "export GOPATH=/home/vagrant/go" >> /home/vagrant/.bash_profile
source /home/vagrant/.bash_profile
mkdir -p "$GOPATH/bin" 

# Verify Go installation
go version

# Install useful Go tools
echo "Installing Go tools..."

# Install goimports
go install golang.org/x/tools/cmd/goimports@latest

# Install air
go install github.com/air-verse/air@latest

# Install Delve
go install github.com/go-delve/delve/cmd/dlv@latest

# Install golint
go install golang.org/x/lint/golint@latest

# Install go vet
# go install golang.org/x/tools/cmd/govet@latest