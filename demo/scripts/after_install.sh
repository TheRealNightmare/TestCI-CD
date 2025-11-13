#!/bin/bash
# This script runs as root
# Navigate to the app directory
cd /var/www/my-nuxt-app

# Set ownership to the 'ubuntu' user
chown -R ubuntu:ubuntu /var/www/my-nuxt-app