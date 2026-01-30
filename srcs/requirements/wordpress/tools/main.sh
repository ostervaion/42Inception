#set -e command makes that if anything fails it stops executing

set -e 

sed 's/\#   include \"mod_fastcgi.conf\"/include \"mod_fastcgi.conf\"/g' /etc/lighttpd/lighttpd.conf
mkdir -p /usr/share/webapps/
cd /usr/share/webapps/
wget    https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz && rm latest.tar.gz
chown -R lighttpd /usr/share/webapps/
ln -s /usr/share/webapps/wordpress/ /var/www/localhost/htdocs/wordpress
/usr/bin/mariadb_install_db --user=mysql
/etc/init.d/mariadb setup
#rc-service mariadb start && rc-update add mariadb default
/usr/bin/mysqladmin -u root password 'Wordpress_1'