#!/bin/bash
cd /var/www/html

# Symlink files needed for config and repository authentication.
if ! [ -f composer.json ];
then
    ln -s /var/www/html/composer/composer.json
fi

if ! [ -f /root/.config/composer/auth.json ];
then
    ln -s /var/www/html/composer/auth.json /root/.config/composer/auth.json
fi

if ! [ -f /root/.gitconfig ];
then
    ln -s /var/www/html/composer/.gitconfig /root/.gitconfig
fi

if ! [ -f /root/.ssh/known_hosts ];
then
    ln -s /var/www/html/composer/known_hosts /root/.ssh
fi

# Install packages.
composer i -o -q --no-interaction --no-progress
