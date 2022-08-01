#!/bin/sh

if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	#Paste string for listen 9000 in php-fpm
	sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
	chmod -R 775 /var/www/html/wordpress;
	chown -R www-data /var/www/html/wordpress;
	
	#Download wordpress
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

	#Update configuration file
	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
	mv ./www.conf /etc/php/7.3/fpm/pool.d/

	cp /var/www/html/wp-config.php /var/www/html/wordpress/wp-config.php 
	
	cd /tmp/
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar;
	mv wp-cli.phar /usr/local/bin/wp;
	cd /var/www/html/wordpress/
	
	wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};
	wp user create ${MYSQL_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${MYSQL_PASSWORD} --role=author --allow-root;
	wp theme install twentyseventeen --activate --allow-root;
	


fi

/usr/sbin/php-fpm7.3 -F;
exec "$@"
