#!/bin/bash
set -e  # Stop the script if any command fails

echo "Fixing potential Nginx user issue..."
sudo sed -i 's/user nginx;/user www-data;/' /etc/nginx/nginx.conf

echo "Testing Nginx configuration..."
if sudo nginx -t; then
    echo "Restarting Nginx..."
    sudo systemctl restart nginx
    echo "Nginx restarted successfully!"
else
    echo "Nginx configuration test failed. Fix errors before restarting."
    exit 1
fi
