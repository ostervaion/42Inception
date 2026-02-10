FROM alpine:3.22

# Install PHP-FPM and WordPress dependencies
RUN apk update && apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-curl \
    php82-dom \
    php82-exif \
    php82-fileinfo \
    php82-mbstring \
    php82-openssl \
    php82-xml \
    php82-zip \
    php82-phar \
    php82-intl \
    php82-gd \
    php82-session \
    php82-tokenizer \
    php82-xmlwriter \
    php82-simplexml \
    php82-iconv \
    less \
    mariadb-client

# Install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy setup script
COPY tools/main.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/main.sh

# Create necessary directories
RUN mkdir -p /var/www/html && \
    chown -R nobody:nobody /var/www/html && \
    mkdir -p /run/php

WORKDIR /var/www/html

EXPOSE 9000

CMD ["/usr/local/bin/main.sh"]
