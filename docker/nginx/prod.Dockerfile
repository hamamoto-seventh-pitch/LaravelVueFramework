FROM amazonlinux:2

COPY ./docker/nginx/etc/yum.repos.d/nginx.repo /etc/yum.repos.d/nginx.repo

# install nginx
RUN yum install -y nginx \
    && rm -rf /var/cache/yum/* \
    && yum clean all

RUN mv /etc/localtime /etc/localtime.org && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime



COPY ./docker/nginx/etc/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/nginx/etc/conf.d/prod.conf /etc/nginx/conf.d/default.conf

COPY ./app/ice_climber /work/ice_climber

# automatic start
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]