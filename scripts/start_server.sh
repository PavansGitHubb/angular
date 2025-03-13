#!/bin/bash
set -e

# Remove default Nginx config
sudo rm -f /etc/nginx/nginx.conf

# Add new Nginx config for Angular
cat <<EOF | sudo tee /etc/nginx/nginx.conf
user nginx;
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

# Restart Nginx to apply changes
sudo systemctl restart nginx
