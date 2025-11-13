#!/bin/bash
# This script runs as the 'ubuntu' user

# We moved the 'chown' command to the appspec.yml 'permissions' section.
# That section is run by the root CodeDeploy agent, so we don't
# need to (and can't) run chown here as the 'ubuntu' user.

# This script is a good place to install dependencies if you weren't
# zipping node_modules, but since you are, we can leave it empty
# or just log a success message.

echo "AfterInstall hook ran successfully as ubuntu user."
# You can add other setup commands here if needed.