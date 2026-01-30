FROM alpine:3.22

COPY tools/main.sh /usr/local/bin/

RUN  apk update && apk add --no-cache \
        mariadb \
        mariadb-client &&\
        chmod +x /usr/local/bin/main.sh && \
        mariadb-install-db --user=mysql --datadir=/var/lib/mysql

        
CMD cd '/usr' &&\
        /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' 

WORKDIR /app