#!/bin/bash

# Set the threshold for disk usage (90% in this case)
THRESHOLD=90

# Get the current disk usage
DISK_USAGE=$(df -h / | awk 'NR==2{print $5}' | cut -d'%' -f1)

# Check if disk usage exceeds the threshold
if [ "$DISK_USAGE" -ge "$THRESHOLD" ]; then
    # Define the email subject and body
    SUBJECT="Disk Space Alert on $(hostname)"
    BODY="Disk usage on $(hostname) has exceeded $THRESHOLD%.\n\nCurrent Disk Usage: $DISK_USAGE%"

    # Send the email notification
    echo -e "$BODY" | mail -s "$SUBJECT" your_email@example.com
fi
