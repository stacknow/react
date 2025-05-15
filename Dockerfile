# Stage 1: Build the React app
FROM node:18-alpine as build
WORKDIR /app
# Copy dependency definitions
COPY package.json package-lock.json ./
# Install dependencies
RUN npm install
# Copy the rest of your app's source code
COPY . .
# Build the app for production
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:stable-alpine
# Copy the build files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html
# Expose port 80
EXPOSE 80
# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
