#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

cd /var/www/my-nuxt-app

# Set your region
REGION="ap-southeast-1"

# Create the .env file from AWS Parameter Store
# This command pulls all keys under the path and formats them as KEY=VALUE
aws ssm get-parameters-by-path \
    --path "/my-nuxt-app/prod" \
    --with-decryption \
    --region "$REGION" \
    --query "Parameters" \
    --output text | awk -F'\t' '{print $4 "=" $7}' > .env

# Set correct owner for the .env file
# (Change 'ubuntu:ubuntu' to 'ec2-user:ec2-user' if you used Amazon Linux 2)
chown ubuntu:ubuntu .env

# Start the app as 'ubuntu' user
# (Change 'ubuntu' to 'ec2-user' if you used Amazon Linux 2)
# Nuxt 3 automatically loads the .env file
sudo -u ubuntu pm2 start .output/server/index.mjs --name "my-nuxt-app"