#!/bin/bash
# This script is already running as the 'ubuntu' user

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd /var/www/my-nuxt-app

# Set your region (e.g., Singapore)
REGION="ap-southeast-1"

# Create the .env file from AWS Parameter Store
# The file will be created with 'ubuntu' as the owner
aws ssm get-parameters-by-path \
    --path "/my-nuxt-app/prod" \
    --with-decryption \
    --region "$REGION" \
    --query "Parameters" \
    --output text | awk -F'\t' '{print $4 "=" $7}' > .env

# The 'chown ubuntu:ubuntu .env' line was removed because it's
# redundant. The 'ubuntu' user is already creating this file.

# Start the app. No 'sudo' is needed.
# Ensure PM2 is installed globally for the ubuntu user via nvm
pm2 start .output/server/index.mjs --name "my-nuxt-app"
pm2 save