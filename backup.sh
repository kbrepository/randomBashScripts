#!/bin/bash

# Define paths
backup_folder="/path/to/backup"
source_folder="/path/to/source"

# Create a file to store the previous state
state_file="$backup_folder/previous_state.txt"

# Check if state file exists
if [ ! -e "$state_file" ]; then
    touch "$state_file"
fi

# Get the current state of the source folder
current_state=$(find "$source_folder" -type f -exec md5sum {} + | sort)

# Get the previous state from the state file
previous_state=$(cat "$state_file")

# Compare current state with previous state
if [ "$current_state" != "$previous_state" ]; then
    # Backup only if changes are identified
    timestamp=$(date +"%Y%m%d%H%M%S")
    backup_file="$backup_folder/backup_$timestamp.tar.gz"
    tar -zcvf "$backup_file" "$source_folder"
    
    # Update the state file with the new state
    echo "$current_state" > "$state_file"
    
    echo "Backup created at $timestamp"
else
    echo "No changes identified. Skipping backup."
fi
