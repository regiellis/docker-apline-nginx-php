#!/bin/sh
echo 'Running configrations';
sed -i "s|;*daemonize\s*=\s*yes|daemonize = no|g" /etc/php7/php-fpm.conf;
sed -i "s|;*listen\s*=\s*127.0.0.1:9000|listen = 9000|g" /etc/php7/php-fpm.d/www.conf;
sed -i "s|;listen\s*=\s*/||g" /etc/php7/php7-fpm.d/www.conf;
sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php7/php.ini;
sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini;
sed -i "s|;*upload_max_filename =.*|upload_max_filename = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini;
sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini;
sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini;
sed -i "s|;*cgi.fix_pathinfo =.*|cgi.fix_pathinfo = 0|i" /etc/php7/php.ini;
