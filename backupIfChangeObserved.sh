You can achieve this using a bash script by using a combination of `find` and `md5sum` to track changes in the folder. Here's an example script:

```bash
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
```

Explanation:

1. Define the `backup_folder` (where backups will be stored) and `source_folder` (the folder to monitor for changes).
2. Create a `state_file` to store the previous state of the source folder.
3. Check if the `state_file` exists, and create it if not.
4. Use `find` and `md5sum` to generate a checksum for each file in the source folder, and sort them.
5. Compare the current state with the previous state.
6. If changes are identified, create a backup with a timestamp and update the `state_file` with the new state.

To use this script, replace `"/path/to/backup"` and `"/path/to/source"` with your actual paths. Make sure to set execute permissions (`chmod +x script_name.sh`) and run it in an environment where you have the necessary permissions.

This script will only create a backup when changes are identified in the source folder. It checks the file contents, so any changes (additions, deletions, or modifications) will trigger a backup.
