# Use a base image for building your React app
FROM node:14 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# Use a lightweight Nginx image to serve your app
FROM nginx:latest
# Copy the built React app from the previous stage
COPY --from=build /app/build /usr/share/nginx/html
# Expose the default port for Nginx
EXPOSE 80
# Nginx runs automatically in the base image
