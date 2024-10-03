#!/bin/bash

# Default domain
DOMAIN="karaok.shmulious.com"

# Check if a custom domain is provided as an argument
if [ "$1" ]; then
    DOMAIN=$1
fi

# Get the current directory where the script is being run
CURRENT_DIR=$(pwd)

# 2.1: Set a Static IP Address
# This requires sudo privileges, and we'll assume you want to set it to 192.168.1.100
# Ensure the gateway matches your network's router IP.
echo "Setting static IP..."
sudo networksetup -setmanual Wi-Fi 192.168.1.100 255.255.255.0 192.168.1.1
echo "Static IP set to 192.168.1.100"

# 2.2: Start a Python Web Server in the directory from which the script is run
echo "Starting Python web server in $CURRENT_DIR..."
cd "$CURRENT_DIR"
python3 -m http.server 8000 &

# 2.3: Host the Webpage
# The Python server will automatically host the folder, no further action needed here.

# 2.4: Create a Local Domain
# Modify /etc/hosts to create a local domain for this IP
echo "Adding local domain '$DOMAIN'..."
sudo -- sh -c "echo '192.168.1.100 $DOMAIN' >> /etc/hosts"
echo "Local domain '$DOMAIN' added."

echo "Your webpage is now accessible at http://$DOMAIN:8000"

# Keep the script running until interrupted
echo "Press [CTRL+C] to stop the server."
wait