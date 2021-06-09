FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install vim -y
RUN apt-get install apt-utils -y
RUN apt-get update
RUN apt-get install apache2 -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get install  php7.3 -y \
  libapache2-mod-php7.3 php7.3-common php7.3-mysql \
  php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring \
  php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip \
  php7.3-sybase freetds-common freetds-bin \
  php7.3-xdebug

COPY php.ini /etc/php/7.3/apache2/php.ini
RUN chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" /var/www/html/
RUN phpenmod xdebug
RUN a2enmod rewrite

EXPOSE 80
EXPOSE 9000
CMD apachectl -D FOREGROUND
