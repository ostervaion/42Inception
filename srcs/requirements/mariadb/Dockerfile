FROM alpine:3.22

COPY ["main.sh", "/usr/local/bin/"]

RUN  apk update && apk add --no-cache \
        mariadb \
        mariadb-client && \
        chmod +x /usr/local/bin/main.sh

WORKDIR /app


ENV LANG en_US.UTF-8
