# Step 1: Build the Vite app
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the app for production
RUN npm run build

# Step 2: Serve with NGINX
FROM nginx:alpine

# Copy the build output to NGINX's public directory
COPY --from=build /app/dist /usr/share/nginx/html

# Remove the default NGINX configuration
RUN rm /etc/nginx/conf.d/default.conf

# Add a custom NGINX configuration
COPY nginx.conf /etc/nginx/conf.d

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
