FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libzip-dev \
    libonig-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl

# Install additional PHP extension oniguruma
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libonig5 \
    && rm -rf /var/lib/apt/lists/*

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
