FROM alpine:3.22

COPY tools/main.sh /usr/local/bin/

RUN  apk update && apk add --no-cache \
        mariadb \
        mariadb-client &&\
	mkdir -p /run/mysqld && \
    	chown mysql:mysql /run/mysqld && \
        chmod +x /usr/local/bin/main.sh && \
        mariadb-install-db --user=mysql --datadir=/var/lib/mysql
#	cd '/usr' &&\
#        /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' 

#CMD ["/usr/bin/mysqld", "--user=mysql", "--console"]
        
#CMD cd '/usr' &&\
#        /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' 

CMD ["/usr/bin/mariadbd", "--user=mysql", "--console"]

WORKDIR /app
