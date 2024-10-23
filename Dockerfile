FROM php:8.0-cli-buster
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -qq -y install \
                   zip unzip \
                   git \
                   ssh \
                   openssh-client \
                   nodejs \
                   yarn

RUN pecl install apcu \
        && docker-php-ext-enable apcu \
        && pecl clear-cache

RUN apt-get update && apt-get install -y \
            libmcrypt-dev \
            && pecl install mcrypt \
            && docker-php-ext-enable mcrypt \
            && pecl clear-cache

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get update \
	&& apt-get install -y \
		libicu-dev \
	&& docker-php-ext-install -j$(nproc) \
		intl \
	&& apt-get purge -y \
		libicu-dev

RUN apt-get update \
	&& apt-get install -y \
		libmagickwand-dev --no-install-recommends \
		ghostscript --no-install-recommends \
	&& pecl install \
		imagick \
	&& docker-php-ext-enable \
		imagick \
	&& apt-get purge -y \
		libmagickwand-dev

RUN apt-get update \
    	&& apt-get install -y \
    	libcurl4-openssl-dev \
    	&& docker-php-ext-install curl

RUN docker-php-ext-install bcmath
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install soap
RUN docker-php-ext-install xml

RUN apt-get update \
    	&& apt-get install -y \
    	libzip-dev \
    	&& docker-php-ext-install zip

RUN docker-php-ext-install exif
# RUN docker-php-ext-install mbstring

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer
