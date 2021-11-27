FROM amazonlinux:2

# TimeZone
RUN cp /usr/share/zoneinfo/Japan /etc/localtime

# update yum
RUN yum update -y \
    && rm -rf /var/cache/yum/* \
    && yum clean all

# install basement
RUN yum install -y \
        curl \
        git \
        libxml2 \
        libxml2-devel \
        systemd \
        mysql \
        gcc \
        vim \
        make \
        mod_ssl \
        wget \
        unzip \
        tar \
        glibc-langpack-ja \
    && rm -rf /var/cache/yum/* \
    && yum clean all

##### PHP関連のパッケージインストール #####
# php7.4用epel, remi repositoryをインスール
RUN amazon-linux-extras install php7.4 -y \
    && yum install -y \
        php-mbstring \
        php-xml \
    && rm -rf /var/cache/yum/* \
    && yum clean all

COPY ./app/ice_climber /work/ice_climber
COPY ./app/ice_climber/.env.example /work/ice_climber/.env
COPY ./docker/php/prod.entrypoint.sh /etc/entrypoint.sh
COPY ./docker/php/php-fpm.d/www.conf /etc/php-fpm.d/www.conf
COPY ./docker/php/conf/php.ini /etc/php.ini

ENV LANG ja_JP.UTF-8
ENV LC_ALL ja_JP.UTF-8

# change working directory
WORKDIR /work/ice_climber
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer install

# ##### install nodejs, npm #####
RUN curl --silent --location https://rpm.nodesource.com/setup_12.x | bash - \
    && yum install -y nodejs \
    && npm install -g npm@6.14.11 \
        n@6.5.1 \
    && n 12.22.0 \
    && ln -sf /usr/local/bin/node /usr/bin/node \
    && npm install -g @vue/cli \
    && yum remove -y nodejs \
    && rm -rf /var/cache/yum/* \
    && yum clean all

RUN npm install \
    && npm run prod

RUN php artisan key:generate
RUN php artisan config:clear

VOLUME /work/ice_climber

EXPOSE 9000

RUN chmod +x /etc/entrypoint.sh

ENTRYPOINT ["/etc/entrypoint.sh"]


