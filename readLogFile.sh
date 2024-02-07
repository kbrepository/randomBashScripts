#!/bin/bash

log_file="path/to/your/log/file.log"  # Replace this with the path to your log file
search_string="application has exited"
count=0

# Loop until the count reaches 5
while [ $count -lt 5 ]; do
    # Read each line of the log file
    while read -r line; do
        # Check if the line contains the search string
        if [[ $line == *"$search_string"* ]]; then
            ((count++))  # Increment the count
            echo "Encountered '$search_string' $count times."
            if [ $count -eq 5 ]; then
                echo "Reached 5 occurrences of '$search_string'. Exiting."
                exit 0
            fi
        fi
    done < "$log_file"
    # Wait for a short duration before reading the file again
    sleep 1
done
