#!/bin/bash
set -e  # Exit if any command fails

# Move all files from /var/www/html/dist/ to /var/www/html/
if [ -d "/var/www/html/dist" ]; then
    echo "Moving Angular build files to /var/www/html/"
    sudo mv /var/www/html/dist/* /var/www/html/
    sudo rm -rf /var/www/html/dist  # Remove the empty dist folder
else
    echo "Warning: No dist folder found in /var/www/html/"
fi

# Set correct ownership and permissions
sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html -type d -exec chmod 755 {} \;
sudo find /var/www/html -type f -exec chmod 644 {} \;

# Restart Nginx
sudo systemctl restart nginx
