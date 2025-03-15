#!/bin/bash
set -e  # Exit if any command fails

# Remove default Nginx config if it exists
sudo rm -f /etc/nginx/nginx.conf

# Add new Nginx config for Angular
cat <<EOF | sudo tee /etc/nginx/nginx.conf
user www-data;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;
events {
    worker_connections 1024;
}
http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    sendfile on;
    keepalive_timeout 65;
    server {
        listen 80;
        server_name _;
        root /var/www/html;
        index index.html;
        location / {
            try_files \$uri /index.html;
        }
    }
}
EOF

# Test Nginx configuration
sudo nginx -t

# Restart Nginx to apply changes
sudo systemctl restart nginx

echo "Nginx restarted successfully!"
