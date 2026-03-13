#!/usr/bin/env bash
set -euo pipefail

APP_DIR="/var/www/simple-application"
RELEASE_DIR="$APP_DIR/current"
ARTIFACT="/tmp/simple-application.tar.gz"

sudo mkdir -p "$APP_DIR"
sudo rm -rf "$RELEASE_DIR"
sudo mkdir -p "$RELEASE_DIR"
sudo tar -xzf "$ARTIFACT" -C "$RELEASE_DIR"

cd "$RELEASE_DIR"

npm ci --omit=dev

pm2 delete simple-application || true
PORT=3000 NODE_ENV=production pm2 start bin/www --name simple-application
pm2 save
