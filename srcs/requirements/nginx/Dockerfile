FROM alpine:3.22

RUN  apk update && apk add --no-cache \
nginx \
openssl

COPY tools/main.sh /usr/local/bin/

COPY tools/cert.pem tools/key.pem /etc/nginx/ssl/

COPY tools/index.html /www/

COPY tools/nginx.conf /etc/nginx/

CMD nginx

CMD /bin/sh

WORKDIR /app
