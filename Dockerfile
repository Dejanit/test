# Stage 1: Build the Node.js application
FROM node:14 AS build
WORKDIR /app
# Copy package.json and package-lock.json separately to leverage Docker's build cache
COPY package*.json ./
RUN npm install
# Copy the rest of the application source code
COPY . .
# Build the application
RUN npm run build  # Ensure 'dist' is generated here
# Stage 2: Serve the application with Nginx
FROM nginx:alpine
# Remove the default Nginx configuration
RUN rm -rf /etc/nginx/conf.d
# Copy your custom Nginx configuration
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# Copy the built application from the first stage
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
