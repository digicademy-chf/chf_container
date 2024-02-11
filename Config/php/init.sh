#!/bin/bash
composer install
./vendor/bin/typo3 setup --force --password --admin-user-password
