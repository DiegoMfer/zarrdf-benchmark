#!/bin/bash

# List of target directories
target_dirs=("benchmark-hdt" "benchmark-tpf")

# Source directory for .hdt files
source_data_dir="data"

# Loop through each target directory
for dir in "${target_dirs[@]}"; do
    # Check if the directory exists
    if [ -d "$dir" ]; then
        # Remove the existing 'data' folder if it exists
        if [ -d "$dir/data" ]; then
            rm -rf "$dir/data"
            echo "Removed existing 'data' folder inside $dir"
        fi
        
        # Create the 'data' folder
        mkdir -p "$dir/data"
        echo "Created new 'data' folder inside $dir"

        # Copy .hdt files from the source data directory
        if [ -d "$source_data_dir" ]; then
            cp "$source_data_dir"/*.hdt "$dir/data" 2>/dev/null
            echo "Copied .hdt files from $source_data_dir to $dir/data"
        else
            echo "Source data directory $source_data_dir does not exist. Skipping file copy."
        fi
    else
        echo "Directory $dir does not exist. Skipping."
    fi
done

# Completion message
echo "Script execution completed."
