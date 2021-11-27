FROM php:8.0.8-fpm

# php.ini、xdebug.iniをコピー
COPY ./conf/php.ini /usr/local/etc/php/php.ini

# Composer install
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

#node.jsインストール
COPY --from=node:10.22 /usr/local/bin /usr/local/bin
COPY --from=node:10.22 /usr/local/lib /usr/local/lib

RUN apt-get update \
    && apt-get install -y \
    git \
    zip \
    unzip \
    vim \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ \
    && docker-php-ext-install pdo_mysql bcmath -j$(nproc) gd \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug

EXPOSE 9000

WORKDIR /work/project