FROM php:7.3.22-cli
RUN apt-get update

RUN apt-get -qq -y install git
RUN apt-get -qq -y install ssh
RUN apt-get -qq -y install scp
RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
