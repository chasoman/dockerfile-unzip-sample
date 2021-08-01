FROM registry.access.redhat.com/ubi7/ubi

MAINTAINER chasoman <soman.chaitanya@gmail.com>

ENV PORT=8080

COPY custom-chasoman-greeting.zip /tmp/

RUN yum install -y httpd && \
    yum install -y unzip && \
    yum clean all && \
    unzip /tmp/custom-chasoman-greeting.zip -d /var/www/html/ && \
    sed -ri -e "/^Listen 80/c\Listen ${PORT}" /etc/httpd/conf/httpd.conf && \
    chown -R apache:apache /etc/httpd/logs/ && \
    chown -R apache:apache /run/httpd/

USER apache

EXPOSE ${PORT}

CMD ["httpd", "-D", "FOREGROUND"]