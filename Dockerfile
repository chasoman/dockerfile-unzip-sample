# Extend the RedHat Linux Universal Base Image (ubi) v7
# Note: access to registry.redhat.io required for this step
FROM registry.access.redhat.com/ubi7/ubi

MAINTAINER chasoman <soman.chaitanya@gmail.com>

# Define the environment variable PORT having a value 8080
ENV PORT=8080

# Copy the custom-chasoman-greeting.zip to the temp directory on the image
COPY custom-chasoman-greeting.zip /tmp/

# Install Apache HTTP Server (httpd)
RUN yum install -y httpd && \
    # Install unzip utility
    yum install -y unzip && \
    yum clean all && \
    # Unzip the custom-chasoman-greeting.zip to the httpd work path
    unzip /tmp/custom-chasoman-greeting.zip -d /var/www/html/ && \
    # Modify the httpd.conf replace the TCP 80 port with 8080
    sed -ri -e "/^Listen 80/c\Listen ${PORT}" /etc/httpd/conf/httpd.conf && \
    chown -R apache:apache /etc/httpd/logs/ && \
    chown -R apache:apache /run/httpd/

USER apache

EXPOSE ${PORT}

# Run httpd on container startup
CMD ["httpd", "-D", "FOREGROUND"]