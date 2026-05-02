FROM php:8.2-cli

WORKDIR /var/www

RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    git \
    libzip-dev \
    && docker-php-ext-install zip pdo pdo_mysql

COPY . .

RUN curl -sS https://getcomposer.org/installer | php \
    && php composer.phar install

EXPOSE 8000