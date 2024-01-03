# This file is part of the CHF Project Container configuration.
#
# For the full copyright and license information, please read the
# LICENSE.txt file that was distributed with this source code.

# Get the standard Debian 12 image (includes PHP 8.2)
FROM docker.io/library/debian:bookworm

# Install packages
RUN apt update && \
    apt install -y \
        bzip2 \
        ca-certificates \
        curl \
        default-mysql-client \
        git \
        gnupg \
        htop \
        locales-all \
        ssh-client \
        vim \
        wget \
# Install image, document, and metadata tools
        ghostscript \
        exiv2 \
        exiftool \
        imagemagick \
# Install Apache and required PHP modules
        apache2 \
        composer \
        libapache2-mod-php \
        php-apcu \
        php-bcmath \
        php-bz2 \
        php-cli \
        php-common \
        php-curl \
        php-fileinfo \
        php-gd \
        php-imagick \
        php-intl \
        php-ldap \
        php-mbstring \
        php-memcached \
        php-mysql \
        php-opcache \
        php-readline \
        php-redis \
        php-soap \
        php-uploadprogress \
        php-xdebug \
        php-xml \
        php-xmlrpc \
        php-zip

# Configure Apache webserver
RUN a2enmod deflate rewrite headers mime expires ssl

# Retrieve all PHP packages and TYPO3 languages
RUN composer update && \
    typo3 language:update

# Set the working directory
WORKDIR /var/www/html