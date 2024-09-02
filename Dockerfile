FROM nginx:latest

# Maintainer label
LABEL maintainer="Sachin Yadav"

# Email label
LABEL email="sachin.yadav@demo.com"

# Create necessary directories and set permissions
RUN mkdir -p /var/cache/nginx/client_temp /var/run/nginx \
    && chmod -R 777 /var/cache/nginx /var/run/nginx /var/run/

# Copy custom Nginx configuration file to the container
ADD https://github.com/sachin78y/docker-images/raw/master/nginx.conf /tmp
RUN cp /tmp/nginx.conf /etc/nginx/nginx.conf && rm -rf /tmp/nginx.conf

# Add custom content to the default index page for permissions
RUN echo "Welcome to  Hitachi !!!" > /usr/share/nginx/html/index.html

# Ensure /etc/nginx/conf.d/ is writable
RUN chmod -R 777 /etc/nginx/conf.d/

# Add a health check to monitor Nginx's status
HEALTHCHECK --interval=30s --timeout=10s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Set default timezone to UTC
ENV TZ=IST

# Expose port 8080
EXPOSE 8080

# Add a custom environment variable
ENV MY_CUSTOM_VAR="Hello from Hitach !!!"

# Print a custom message on container start
CMD ["sh", "-c", "echo $MY_CUSTOM_VAR && exec nginx -g 'daemon off;'"]
