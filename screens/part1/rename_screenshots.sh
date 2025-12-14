#!/bin/bash

# Shell script to rename screenshots for Part 1: FastAPI Deployment
# This script renames screenshots to meaningful names for the lab report

echo "========================================="
echo "Renaming Screenshots for Part 1"
echo "========================================="

# Define the mapping of old names to new names
# Format: "old_name:new_name"
declare -a mappings=(
    "Screenshot 2025-12-14 201201:part1_01_server_running"
    "Screenshot 2025-12-14 201646:part1_02_swagger_ui"
    "Screenshot 2025-12-14 201824:part1_03_swagger_input"
    "Screenshot 2025-12-14 202023:part1_04_swagger_response"
    "Screenshot 2025-12-14 202039:part1_05_swagger_full_output"
    "Screenshot 2025-12-14 202427:part1_06_python_test_api"
)

# Get the file extension (assuming .png, change if needed)
extension=".png"

# Rename each file
for mapping in "${mappings[@]}"; do
    # Split the mapping into old and new names
    old_name="${mapping%%:*}"
    new_name="${mapping##*:}"

    # Construct full file paths
    old_file="${old_name}${extension}"
    new_file="${new_name}${extension}"

    # Check if old file exists
    if [ -f "$old_file" ]; then
        mv "$old_file" "$new_file"
        echo "✓ Renamed: $old_file -> $new_file"
    else
        echo "✗ File not found: $old_file"
    fi
done

echo "========================================="
echo "Renaming Complete!"
echo "========================================="
