FROM centos:7

MAINTAINER Jindřich Káňa <jindrich.kana@gmail.com>
LABEL Vendor="T-Mobile"

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm \
        &&  yum -y --setopt=tsflags=nodocs update \
        && yum --setopt=tsflags=nodocs -y install \
        gcc \
        gcc-c++ \
        httpd \
        mod_ssl \
        php \
        php-cli \
        php-devel \
        php-mysql \
        php-pdo \
        php-mbstring \
        php-soap \
        php-gd \
        php-xml \
        php-pecl-apcu \
        libXrender fontconfig libXext urw-fonts \
        && rm -rf /var/cache/yum/* \
        && yum clean all

ADD https://raw.githubusercontent.com/tmobil-demo/app/master/run-httpd.sh /usr/local/bin/
ADD https://raw.githubusercontent.com/tmobil-demo/app/master/reviews.html /var/www/html/
ADD https://raw.githubusercontent.com/tmobil-demo/app/master/addreview.php /var/www/html/

RUN find /var/www/html/ -type d -exec chmod 755 {} \; \
    && find /var/www/html/ -type f -exec chmod 644 {} \; \
    && chmod -v +x /usr/local/bin/run-httpd.sh

EXPOSE 8080

CMD ["/usr/local/bin/run-httpd.sh"]
