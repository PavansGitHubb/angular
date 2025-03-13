#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

# Update package lists
sudo apt update -y

# Install required dependencies (modify as per your project)
sudo apt install -y nginx unzip nodejs npm

# Optional: Verify installations
nginx -v
node -v
npm -v
