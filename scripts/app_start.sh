#!/bin/bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Navigate to the app directory
cd /var/www/my-nuxt-app

# (Change 'ubuntu' to 'ec2-user' if you used Amazon Linux 2)
# We run the start command as the 'ubuntu' user, not as root
sudo -u ubuntu pm2 start .output/server/index.mjs --name "my-nuxt-app"