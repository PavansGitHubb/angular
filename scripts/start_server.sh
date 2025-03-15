#!/bin/bash
set -e

# Move Angular build files to the correct location
sudo mv /var/www/html/browser/* /var/www/html/
sudo rm -rf /var/www/html/browser

# Remove default Nginx config
sudo rm -f /etc/nginx/sites-enabled/default

# Add new Nginx config for Angular
cat <<EOF | sudo tee /etc/nginx/sites-available/angular
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;
    
    location / {
        try_files \$uri /index.html;
    }
    
    error_page 404 =200 /index.html;
}
EOF

# Enable the new config
sudo ln -s /etc/nginx/sites-available/angular /etc/nginx/sites-enabled/angular
sudo rm -f /etc/nginx/sites-enabled/default  # Remove old default config

# Restart Nginx
sudo systemctl restart nginx
