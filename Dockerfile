# DFD Docker Environment
# Copyright (C) 2022 Jonatan Jalle Steller <jonatan.steller@adwmainz.de>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Inspired by <https://github.com/martin-helmich/docker-typo3>
# With further input from the PKF and CVMA Docker images
# Certificate and locale manipulation of these images was left out

# When this Docker image is updates, run the following commands
# docker build -f Dockerfile -t registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd-docker/dfd-typo3 .
# docker push registry.gitlab.rlp.net/adwmainz/digicademy/dfd/dfd-docker/dfd-typo3

# MULTISTAGE 1: source image
FROM php:8.1-apache-bullseye as source

# Environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1

# Update the package list
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        libzip-dev \
        libxslt1-dev \
        git \
        ssh-client \
        unzip \
# Configure PHP libraries
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
        libxslt1-dev \
        zlib1g-dev && \
    docker-php-ext-install -j$(nproc) zip xsl gd && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Initialise composer
RUN mkdir -p /root/.config/composer && mkdir -p /root/.ssh
COPY composer/auth.json /root/.config/composer/auth.json
COPY composer/.gitconfig /root/.gitconfig
COPY composer/known_hosts /root/.ssh
RUN chown -R 0600 /root/.ssh
COPY composer/composer.json /var/www/html/composer.json

RUN cd /var/www/html && \
    composer install --optimize-autoloader

# MULTISTAGE 2: development image
FROM php:8.1-apache-bullseye as development

# Add Apache config
COPY --from=source /var/www/html/ /var/www/html/
COPY apache2/000-default.conf /etc/apache2/sites-available/000-default.conf

# Update the package list
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        wget \
        locales \
        git \
        ssh-client \
        default-mysql-client \
        vim \
        mc \
        htop \
        ca-certificates \
# Configure PHP
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
        libxslt1-dev \
        zlib1g-dev \
# Install required third-party tools
        exiv2 \
        exiftool \
        graphicsmagick && \
# Configure extensions
    docker-php-ext-configure gd --with-libdir=/usr/include/ --with-jpeg --with-freetype && \
    docker-php-ext-install -j$(nproc) mysqli soap gd zip opcache intl pgsql pdo_pgsql xsl && \
# Configure Apache as needed
    a2enmod rewrite headers && \
    apt-get clean && \
    apt-get -y purge \
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        libxslt1-dev \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* /usr/src/*

# Install Typo3 and extensions
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    rm /var/www/html/composer.json && cd /var/www/html/ && ln -s composer/composer.json

# Copy files to the right places
COPY php/typo3.ini /usr/local/etc/php/conf.d/typo3.ini

# Install MailHog Sendmail
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.19.1.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go install github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

# Configure volumes
VOLUME /var/www/html/config
VOLUME /var/www/html/composer
VOLUME /var/www/html/htdocs
VOLUME /var/www/html/vendor