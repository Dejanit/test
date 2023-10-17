# Stage 1: Build the React application
FROM node:14 as build

# Set the working directory in the container
WORKDIR /app

# Copy the application's source code to the container
COPY . .

# Install dependencies and build the application with the desired output path
RUN npm install
RUN npm run build -- --output-path=/app/dist

# Stage 2: Serve the application with Nginx
FROM nginx:alpine

# Copy the built application from the build stage to the Nginx web server directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose the port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
