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


ENTRYPOINT ["/usr/local/bin/main.sh"]

WORKDIR /app
