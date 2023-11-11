#!/bin/bash

# Set your source and target directories
source_directory="/home/gpadmin/csv_files"
target_directory="/home/gpadmin/csv_files/archive"

# Set up inotifywait to monitor the source directory for new files
inotifywait -m -e create --format '%w%f' "$source_directory" |
while read -r new_file; do
    echo "New file detected: $new_file"
    gpsscli --gpss-port 8082 start fileevent
    gpsscli --gpss-port 8082 wait fileevent
    # Move the new file to the target directory
    mv "$new_file" "$target_directory"

done
