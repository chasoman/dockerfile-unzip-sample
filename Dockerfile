# Extend the RedHat Linux Universal Base Image (ubi) v7
# Note: access to registry.redhat.io required for this step
FROM registry.access.redhat.com/ubi7/ubi

MAINTAINER chasoman <soman.chaitanya@gmail.com>

# Define the environment variable PORT having a value 8080
ENV PORT=8080

# Install Apache HTTP Server (httpd)
RUN yum install -y httpd && \
    yum clean all && \
    # Modify the httpd.conf replace the TCP 80 port with 8080
    sed -ri -e "/^Listen 80/c\Listen ${PORT}" /etc/httpd/conf/httpd.conf

# Copy the custom-chasoman-greeting.tar.gz to the temp directory on the image
# The ADD command untars the archive and copies the contents to the destination
ADD custom-chasoman-greeting.tar.gz /var/www/html/

EXPOSE ${PORT}

# Run httpd on container startup
CMD ["httpd", "-D", "FOREGROUND"]
