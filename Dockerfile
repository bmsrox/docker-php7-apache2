FROM ubuntu:16.04
MAINTAINER bsdev <bmsrox@gmail.com>
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y dist-upgrade && \
    apt-get update --fix-missing && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install && \
    apt-get -y install apache2 libapache2-mod-php7.0 php7.0 php7.0-cli php-xdebug php7.0-mbstring php7.0-mysql php7.0-dev php7.0-gd php7.0-json php7.0-curl php7.0-intl php7.0-bcmath php7.0-soap curl php-pear && \
    apt-get install -y git && \
    apt-get install -y vim && \
    apt-get install unzip && \
    a2enmod rewrite && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod +x /usr/local/bin/composer && \
    apt-get clean

# Set the time zone
RUN echo "America/Sao_Paulo" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/display_errors = Off/display_errors = On/" /etc/php/7.0/apache2/php.ini
RUN sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/run/
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

WORKDIR /var/www/html

ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
