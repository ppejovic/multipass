#!/bin/bash

# Exit immediately if a command fails
set -e

# Define variables
PROFILE="dev"
INSTANCE_NAME="dev"
CLOUD_CONFIG_FILE="${PROFILE}-cloud-config.yaml"

# Check if the SSH public key file exists
if [[ ! -f ~/.ssh/id_rsa.pub ]]; then
    echo "Error: SSH public key file not found at ~/.ssh/id_rsa.pub"
    exit 1
fi

# Read the SSH public key
SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)

# Create the cloud-config file
cat > "$CLOUD_CONFIG_FILE" <<EOL
#cloud-config
users:
  - name: ubuntu
    ssh_authorized_keys:
      - $SSH_PUBLIC_KEY
EOL

# Launch the Multipass instance
multipass launch \
    --name "$INSTANCE_NAME" \
    --cloud-init "$CLOUD_CONFIG_FILE" \
    lts

echo "Multipass instance '$INSTANCE_NAME' launched successfully."