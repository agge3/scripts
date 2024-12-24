#!/usr/bin/env bash

# Check if the correct number of arguments is provided.
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <search_pattern> <replace_pattern> <file>"
  exit 1
fi

search_pattern="${1}"
replace_pattern="${2}"
file="${3}"

# Use the current directory to construct the file path.
file="${PWD}/${file}"

sed -i "s/${search_pattern}/${replace_pattern}/g" "${file}"

# Print a success message.
echo "Replaced all occurrences of ${search_pattern} with ${replace_pattern} in ${file}."
