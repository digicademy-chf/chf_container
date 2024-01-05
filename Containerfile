# This file is part of the CHF Container environment.
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
        libapache2-mod-php8.2 \
        php8.2-apcu \
        php8.2-bcmath \
        php8.2-bz2 \
        php8.2-cli \
        php8.2-common \
        php8.2-curl \
        php8.2-fileinfo \
        php8.2-gd \
        php8.2-imagick \
        php8.2-intl \
        php8.2-ldap \
        php8.2-mbstring \
        php8.2-memcached \
        php8.2-mysql \
        php8.2-opcache \
        php8.2-readline \
        php8.2-redis \
        php8.2-soap \
        php8.2-uploadprogress \
        php8.2-xdebug \
        php8.2-xml \
        php8.2-xmlrpc \
        php8.2-zip

# Configure Apache webserver
RUN a2enmod deflate rewrite headers mime expires ssl

# Retrieve all PHP packages and TYPO3 languages
RUN composer update && \
    typo3 language:update

# Set the working directory
WORKDIR /var/www/html