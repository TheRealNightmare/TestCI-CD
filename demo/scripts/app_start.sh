#!/bin/bash
# This script is already running as the 'ubuntu' user

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd /var/www/my-nuxt-app

# Set your region to Singapore (where the EC2 & SSM are)
REGION="ap-southeast-1"

# Create the .env file from AWS Parameter Store in ap-southeast-1
aws ssm get-parameters-by-path \
    --path "/my-nuxt-app/prod" \
    --with-decryption \
    --region "$REGION" \
    --query "Parameters" \
    --output text | awk -F'\t' '{print $4 "=" $7}' > .env

# Set correct owner for the .env file
chown ubuntu:ubuntu .env

# Start the app. No 'sudo' is needed.
pm2 start .output/server/index.mjs --name "my-nuxt-app"