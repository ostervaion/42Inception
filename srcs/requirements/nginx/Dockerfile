FROM alpine:3.22

RUN  apk update && apk add --no-cache \
nginx \
openssl

COPY tools/main.sh /usr/local/bin/

#COPY tools/cert.pem tools/key.pem /etc/nginx/ssl/

COPY tools/nginx.conf /etc/nginx/

RUN chmod +x /usr/local/bin/main.sh && \
	mkdir -p /run/nginx /var/www/html && \
	chown -R nobody:nobody /var/www/html

WORKDIR /app

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/main.sh"]
