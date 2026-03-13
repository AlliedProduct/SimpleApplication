#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update
sudo apt-get install -y nginx ufw curl

if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

sudo npm install -g pm2

sudo mkdir -p /var/www/simple-application
sudo cp deploy/nginx-simple-application.conf /etc/nginx/sites-available/simple-application
sudo ln -sf /etc/nginx/sites-available/simple-application /etc/nginx/sites-enabled/simple-application
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl enable nginx

sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable

echo 'Bootstrap complete. Next step: run Certbot and then push to main to trigger deployment.'
