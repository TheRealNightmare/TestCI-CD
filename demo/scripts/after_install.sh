#!/bin/bash
# Navigate to the app directory
cd /var/www/my-nuxt-app

# Set ownership to the 'ubuntu' user
# (Change 'ubuntu:ubuntu' to 'ec2-user:ec2-user' if you used Amazon Linux 2)
chown -R ubuntu:ubuntu /var/www/my-nuxt-app