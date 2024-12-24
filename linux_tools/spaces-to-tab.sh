#!/usr/bin/env bash

# AUTHOR: OpenAI's ChatGPT
# Prompt: "sed 's/^    /\t/' $1 can you make this script more robust well 
# documented clear what it's doing. add a flag to where you can do no backup"
# MODIFIED: 2024-09-29 Tyler Baxter 

# This script replaces leading spaces (four spaces) with a tab character in the specified file.
# Usage: ./script.sh [--no-backup] filename
# The --no-backup flag prevents the creation of a backup file.

# Function to display usage information
usage() {
    echo "Usage: $0 [--no-backup] filename"
    exit 1
}

# Check for at least one argument
if [ $# -lt 1 ]; then
    usage
fi

# Initialize variables
backup=true
input_file=""

# Parse arguments
while [[ "$1" != "" ]]; do
    case $1 in
        --no-backup )
            backup=false
            ;;
        -* )
            echo "Unknown option: $1"
            usage
            ;;
        * )
            input_file="$1"
            ;;
    esac
    shift
done

# Check if a filename was provided
if [ -z "$input_file" ]; then
    usage
fi

# Check if the file exists and is readable
if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' does not exist or is not a regular file."
    exit 1
fi

if [ ! -r "$input_file" ]; then
    echo "Error: File '$input_file' is not readable."
    exit 1
fi

# Create a backup of the original file if the flag is not set
if [ "$backup" = true ]; then
    cp "$input_file" "${input_file}.bak"
fi

# Use sed to replace four leading spaces with a tab character and update the file
sed -i 's/ \{4\}/\t/g' "$input_file"

# Notify the user of completion
if [ "$backup" = true ]; then
    echo "Leading spaces in '$input_file' have been replaced with tabs."
    echo "A backup of the original file has been saved as '${input_file}.bak'."
else
    echo "Leading spaces in '$input_file' have been replaced with tabs. No backup created."
fi
