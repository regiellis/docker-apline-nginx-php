FROM alpine:edge
MAINTAINER Regi Ellis <regi@bynine.io>

ENV TIMEZONE                America/New_York
ENV PHP_MEMORY_LIMIT        512M
ENV MAX_UPLOAD              50M
ENV PHP_MAX_FILE_UPLOAD     200
ENV PHP_MAX_POST            100M

# SYSTEM
RUN \ 
echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --update tzdata && \
    cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    apk add --update

# INSTALL NGINX
RUN \
apk add --update \
nginx

# INSTALL PHP
RUN apk add \
    php7-fpm \
    php7-bcmath \
    php7-bz2 \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-gd \
    php7-gettext \
    php7-gmp \
    php7-iconv \
    php7-json \
    php7-mcrypt \
    php7-mysqli \
    php7-odbc \
    php7-openssl \
    php7-pdo \
    php7-pdo_dblib \
    php7-pdo_mysql \
    php7-pdo_odbc \
    php7-pdo_sqlite \
    php7-soap \
    php7-sqlite3 \
    php7-xmlreader \
    php7-xmlrpc \
    php7-zip

# CONFIGURE PHP
COPY templates/config.sh /tmp
CMD ['/tmp/config.sh']

RUN mkdir /www && \
    chmod -R 775 /www && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*

# CONFIGURE NGINX
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
COPY templates/html /www

WORKDIR /www

VOLUME ["/www"]

EXPOSE 80

#CMD ["/usr/sbin/php-fpm7"]
#ENTRYPOINT ["nginx", "-g", "daemon off;"]

