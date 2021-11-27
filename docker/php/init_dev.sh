#!/bin/bash

# install composer
echo "> composer install"
composer install

# setting up laravel
echo "> php artisan key:generate"
php artisan key:generate
echo "> php artisan config:clear"
php artisan config:clear
echo "> php artisan migrate:fresh"
php artisan migrate:fresh
echo "> php artisan db:seed"
php artisan db:seed

# install & build npm
echo "> npm install"
npm install
echo "> npm run dev"
npm run dev