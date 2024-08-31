FROM nginx:latest

# Create necessary directories and set permissions
RUN mkdir -p /var/cache/nginx/client_temp /var/run/nginx \
    && chmod -R 777 /var/cache/nginx /var/run/nginx /var/run/

# Copy custom Nginx configuration file to the container
ADD https://github.com/sachin78y/docker-images/raw/master/nginx.conf /tmp
RUN cp /tmp/nginx.conf /etc/nginx/nginx.conf && rm -rf /tmp/nginx.conf
RUN echo "Welcome to Dollys World"  > /usr/share/nginx/html/index.html

# Ensure /etc/nginx/conf.d/ is writable
RUN chmod -R 777 /etc/nginx/conf.d/

# Expose port 8080
EXPOSE 8080
