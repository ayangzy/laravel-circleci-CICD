FROM php:8.0.20

RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y  zlib1g-dev \
    libzip-dev \
    unzip \
    supervisor


# Add configuration file for Supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN docker-php-ext-install pdo pdo_mysql sockets zip

RUN mkdir /app

ADD . /app

WORKDIR /app

RUN composer install --no-interaction --prefer-dist --no-suggest

#CMD php artisan serve --host=0.0.0.0 --port=8000

EXPOSE 8000

CMD /bin/sh -C "./run.sh"; /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
