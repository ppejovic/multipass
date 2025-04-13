#!/bin/bash

set -e

PROFILE="dev"
INSTANCE_NAME="dev"
CLOUD_CONFIG_FILE="${PROFILE}-cloud-config.yaml"

if [[ ! -f ~/.ssh/id_rsa.pub ]]; then
    echo "Error: SSH public key file not found at ~/.ssh/id_rsa.pub"
    exit 1
fi

SSH_PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)

cat >> "$CLOUD_CONFIG_FILE" <<EOL

ssh_authorized_keys:
  - $SSH_PUBLIC_KEY
EOL

multipass launch \
    --cpus 2 \
    --memory 2G \
    --name "$INSTANCE_NAME" \
    --cloud-init "$CLOUD_CONFIG_FILE" \
    lts

echo "Multipass instance '$INSTANCE_NAME' launched successfully."