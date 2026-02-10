#!/bin/sh
#set -e

echo "Starting nginx conf"

# Create user only if it doesn't exist
if ! id www >/dev/null 2>&1; then
    adduser -D -g 'www' www
fi

#mkdir -p /run/nginx
#mkdir -p /var/www/html
#chown -R nobody:nobody /var/www/html

echo "Starting nginx"
exec nginx -g "daemon off;"
