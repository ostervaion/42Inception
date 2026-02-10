FROM alpine:3.22

COPY tools/main.sh /usr/local/bin/

COPY tools/mariadb-server.cnf /etc/mariadb/

RUN  apk update && apk add --no-cache \
        mariadb \
        mariadb-client &&\
	mkdir -p /run/mysqld && \
    	chown mysql:mysql /run/mysqld && \
        chmod +x /usr/local/bin/main.sh && \
	mkdir -p /etc/mariadb/


#	cd '/usr' &&\
#        /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' 

#CMD ["/usr/bin/mysqld", "--user=mysql", "--console"]
        
#CMD cd '/usr' &&\
#        /usr/bin/mariadbd-safe --datadir='/var/lib/mysql' 

#CMD ["/usr/local/bin/main.sh", "--console"]

ENTRYPOINT ["/usr/local/bin/main.sh"]

#ENTRYPOINT ["mariadbd","--defaults-file=/etc/mariadb/mariadb-server.cnf", "--user=mysql"]

WORKDIR /app
