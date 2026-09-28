#!/bin/bash

# 1. Install dependencies
echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y sysstat zip procps bc

echo "Dependencies installed successfully!"

# 2. Optional Cron setup
read -p "Do you want to schedule daily automatic backups? (y/N): " choice

case "$choice" in 
    [yY][eE][sS]|[yY])
        SCRIPT_PATH="$(realpath ./backup.sh)"
        
        # Add cron job without duplicating it
        (crontab -l 2>/dev/null | grep -Fv "$SCRIPT_PATH"; echo "0 0 * * * $SCRIPT_PATH") | crontab -
        echo "Cron job scheduled daily at midnight."
        ;;
    *)
        echo "Skipping Cron setup. You can run backups manually."
        ;;
esac
