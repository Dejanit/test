# Stage 1: Build the Node.js application
FROM node:14 AS build
RUN mkdir -p /app
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
# Run your build script to generate the dist directory
RUN npm run build
# Stage 2: Serve the application with Nginx
FROM nginx:alpine
RUN rm -rf /etc/nginx/conf.d
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# Copy the built application from the first stage
COPY --from=build /app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
