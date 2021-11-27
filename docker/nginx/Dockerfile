FROM amazonlinux:2

ARG ENV_DOCUMENT_ROOT
ARG ENV_SRC_DIRECTORY_NAME

COPY ./etc/yum.repos.d/nginx.repo /etc/yum.repos.d/nginx.repo

# install nginx
RUN yum install -y nginx \
    && rm -rf /var/cache/yum/* \
    && yum clean all

RUN mv /etc/localtime /etc/localtime.org && \
    ln -s /usr/share/zoneinfo/Japan /etc/localtime



COPY ./etc/nginx.conf /etc/nginx/nginx.conf
COPY ./etc/conf.d /etc/nginx/conf.d

# automatic start
ENTRYPOINT ["/usr/sbin/nginx", "-g", "daemon off;"]