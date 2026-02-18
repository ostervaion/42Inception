#!/bin/sh
set -e

export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
export MYSQL_USER=$(cat /run/secrets/db_user)
export MYSQL_DATABASE=$(cat /run/secrets/db_name)

export WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
export WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
export WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
export WP_USER_EMAIL=$(cat /run/secrets/wp_user_email)
export WP_USER=$(cat /run/secrets/wp_user)
export WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

echo "Setting up WordPress with WP-CLI..."

# Wait for MariaDB to be ready
echo "Waiting for database..."
until mariadb-admin ping -h"${MYSQL_HOST}" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" --silent 2>/dev/null; do
    echo "Database not ready, waiting..."
    sleep 3
done
echo "Database is ready!"

# Download WordPress if not already present
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Installing WordPress..."
    # Download WordPress core
    wp core download --allow-root
    
    # Create wp-config.php with database settings
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="${MYSQL_HOST}:3306" \
        --allow-root
    
    # Install WordPress (creates admin user, sets up database tables)
    wp core install \
        --url="${WP_URL:-https://juetxeba.42.fr}" \
        --title="${WP_TITLE:-My WordPress Site}" \
        --admin_user="${WP_ADMIN_USER:-admin}" \
        --admin_password="${WP_ADMIN_PASSWORD:-admin123}" \
        --admin_email="${WP_ADMIN_EMAIL:-admin@example.com}" \
        --allow-root
    
    # Optional: Create additional users
    wp user create "${WP_USER:-editor}" "${WP_USER_EMAIL:-editor@example.com}" \
        --role=editor \
        --user_pass="${WP_USER_PASSWORD:-editor123}" \
        --allow-root || true
    
    # Optional: Install and activate plugins
    # wp plugin install contact-form-7 --activate --allow-root
    
    # Optional: Install and activate a theme
    # wp theme install twentytwentyfour --activate --allow-root
    
    # Set correct permissions
    chown -R nobody:nobody /var/www/html
    
    echo "WordPress installation complete!"
else
    echo "WordPress already installed!"
fi

# Configure PHP-FPM
echo "Configuring PHP-FPM..."
sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf
sed -i 's/;listen.owner = nobody/listen.owner = nobody/g' /etc/php82/php-fpm.d/www.conf
sed -i 's/;listen.group = nobody/listen.group = nobody/g' /etc/php82/php-fpm.d/www.conf

echo "Starting PHP-FPM..."
exec php-fpm82 -F
