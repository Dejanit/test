# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the entire project directory into the container
COPY . .

# Build the React app
RUN npm run build

# Expose a port to run your React app (e.g., 80)
EXPOSE 80

# Start the React app when the container starts
CMD ["npm", "start"]
