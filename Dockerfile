# Specify the platform to ensure architecture compatibility
FROM wordpress:latest

# Install the PHP Redis extension
RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        libzip-dev \
        unzip \
    ; \
    docker-php-ext-install zip; \
    \
    # Install Redis PHP extension
    pecl install redis; \
    docker-php-ext-enable redis; \
    \
    # Clean up
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
    rm -rf /var/lib/apt/lists/*; \
    \
    # Verify Redis extension is installed
    php -m | grep -q 'redis'

# The WordPress image already has ENTRYPOINT and CMD defined, so we don't need to redefine them

# Optional: add your custom php.ini settings
# COPY custom-php.ini /usr/local/etc/php/conf.d/