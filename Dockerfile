# DFD Docker Environment
# Copyright (C) 2023 Jonatan Jalle Steller <jonatan.steller@adwmainz.de>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

# Inspired by <https://github.com/martin-helmich/docker-typo3> and
# <https://stackoverflow.com/questions/18136389/using-ssh-keys-inside-docker-container#answer-48565025>

# Get the right Apache image
FROM php:8.2-apache-bullseye as source

# Add Composer
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Prepare folders
RUN mkdir -p /root/scripts && \
#    mkdir -p /root/.config/composer && \
    mkdir -p /root/.ssh && \
    chown -R 0600 /root/.ssh

# Add Apache and PHP config
COPY apache2/conf/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY php/php.ini /usr/local/etc/php/conf.d/php.ini

# Add Composer init script
#COPY scripts/init-composer.sh /root/scripts/init-composer.sh
#RUN chmod +x /root/scripts/init-composer.sh

# Update CA certificates
#RUN sed -i 's/mozilla\/DST_Root_CA_X3.crt/!mozilla\/DST_Root_CA_X3.crt/g' /etc/ca-certificates.conf && \
#    update-ca-certificates

# Install the basics
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        locales \
        git \
        ssh-client \
        default-mysql-client \
        vim \
        mc \
        htop \
        ca-certificates \
# Install image manipulation and metadata libraries
        graphicsmagick \
        ghostscript \
# Install PHP libraries
        libxml2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libpq-dev \
        libzip-dev \
        libxslt1-dev \
        zlib1g-dev && \
# Configure PHP extensions
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) mysqli soap gd zip opcache intl pgsql pdo_pgsql xsl && \
# Configure Apache webserver
    a2enmod rewrite headers ssl && \
    apt-get clean && \
    apt-get -y purge \
        libxml2-dev libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/* /usr/src/*

# Add localisations
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

# Run Composer
#RUN bash /root/scripts/init-composer.sh
