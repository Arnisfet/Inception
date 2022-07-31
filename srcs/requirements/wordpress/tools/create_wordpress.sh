#!/bin/sh

if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
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

	#Inport env variables in the config file
	#cd /var/www/html/wordpress
	#sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	#sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	#sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	#sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	#mv wp-config-sample.php wp-config.php
	cp /var/www/html/wp-config.php /var/www/html/wordpress/wp-config.php 
fi

exec "$@"
