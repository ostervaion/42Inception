FROM alpine:3.22


RUN  apk update && apk add --no-cache \
lighttpd \
php \
fcgi \
php-cgi \
wget \
mariadb \
mariadb-client \
php82-mysqli


COPY tools/main.sh /usr/local/bin/

CMD /bin/sh

WORKDIR /app