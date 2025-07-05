#!/bin/bash

# Define the paths to check and their types (file or directory)
declare -A paths=(
    ["./database.sqlite3"]="file"
    ["./maps"]="directory"
    ["./sm.txt"]="file"
    ["./authorised_names"]="file"
)

for path in "${!paths[@]}"; do
    if [ ! -e "$path" ]; then
        if [ "${paths[$path]}" = "file" ]; then
            echo "Creating file: $path..."
            touch "$path"
        elif [ "${paths[$path]}" = "directory" ]; then
            echo "Creating directory: $path..."
            mkdir -p "$path"
        else
            echo "Invalid type specified for $path"
            exit 1
        fi
        if [ $? -eq 0 ]; then
            echo "Successfully created $path"
        else
            echo "Failed to create $path"
            exit 1
        fi
    else
        echo "$path already exists"
    fi
done

echo "All required paths are ready"
