#!/bin/bash

# Update the package list to make sure we have the latest information
sudo apt-get update

# Install Apache2 web server
sudo apt-get install -y apache2

# Start the Apache2 service
sudo systemctl start apache2

# Enable Apache2 to start on boot
sudo systemctl enable apache2

# Create a basic HTML page to test the web server
echo '<html><head><title>Apache2 Test Page</title></head><body><h1>Welcome to my Apache2 web server!</h1></body></html>' | sudo tee /var/www/html/index.html

# Open port 80 in the firewall to allow web traffic
sudo ufw allow 80

# Reload the firewall to apply changes
sudo ufw reload

