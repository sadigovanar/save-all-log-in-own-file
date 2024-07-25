#!/bin/bash

# Add section to /etc/bashrc
echo "Updating /etc/bashrc..."
cat <<EOL >> /etc/bashrc

# Log each command executed
export PROMPT_COMMAND='RETRN_VAL=\$?;logger -p local6.debug "\$(whoami) [\$$]: \$(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [\$RETRN_VAL]"'
EOL

# Create rsyslog configuration file
echo "Creating /etc/rsyslog.d/bash.conf..."
cat <<EOL | sudo tee /etc/rsyslog.d/bash.conf > /dev/null
local6.*    /var/log/commands.log
EOL

# Restart rsyslog service
echo "Restarting rsyslog service..."
sudo service rsyslog restart

echo "Setup complete. Commands will now be logged to /var/log/commands.log."


#### save script and run###
chmod +x setup_logging.sh
sudo ./setup_logging.sh
