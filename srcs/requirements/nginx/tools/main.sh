#!/bin/sh
set -e

echo "Starting nginx conf"

adduser -D -g 'www' www
mkdir -p /run/nginx
mkdir -p /var/www/html
chown -R nobody:nobody /var/www/html
echo "Starting nginx"
exec nginx -g "daemon off;"
