# Use the Dase Nginx image
FROM nginx:latest

# Copy the HTHL files to the Nginx document root
COPY index.html /usr/share/nginx/html/index.html
COPY style.css /usr/share/nginx/html/style.css

# Expose port 80 to allow incoming HTTP traffic
EXPOSE 80

# Start the Nginx server when the container starts
CMD ["nginx", "-g", "daemon off;"]
