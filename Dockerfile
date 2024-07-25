# Stage 1: Build the React application
FROM node:14 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire application
COPY . .

# Build the React app
RUN npm run build

# Stage 2: Serve the React application with Nginx
FROM nginx:alpine

# Copy the build output from Stage 1 into the Nginx web server's public directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx configuration file to replace the default one
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to the Docker host, so it can be accessed from the outside
EXPOSE 80
