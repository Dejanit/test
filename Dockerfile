# Use a valid Node.js image
FROM node:14 as build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Use nginx:alpine for the production server
FROM nginx:alpine

# Copy the build files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 (this is more for documentation; it doesn't actually publish a port)
EXPOSE 80

# Start nginx with the "daemon off" option to keep it running
CMD ["nginx", "-g", "daemon off;"]
