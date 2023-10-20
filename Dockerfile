# Use an official Nginx image as the parent image
FROM nginx:latest

# Remove the default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/

# Copy the built React app files to the Nginx web root
COPY build/ /usr/share/nginx/html
