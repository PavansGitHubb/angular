#!/bin/bash
set -e

# Install updates
sudo yum update -y

# Install Nginx (if not installed)
if ! command -v nginx &> /dev/null; then
    sudo amazon-linux-extras enable nginx1
    sudo yum install -y nginx
fi

# Start Nginx
sudo systemctl enable nginx
sudo systemctl start nginx
