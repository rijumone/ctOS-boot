#!/bin/bash

# Get the directory of the script
script_dir=$(dirname "$0")

# Set the relative directory containing the text files
cursor_dir="$script_dir/cursor"
module_dir="$script_dir/module"
mask_dir="$script_dir/mask"
rmmask_dir="$script_dir/rmmask"
system_dir="$script_dir/system"

# Function to center text horizontally
center_text() {
    local text="$1"
    local term_cols=$(tput cols)
    local text_length=${#text}
    local padding=$(( (term_cols - text_length) / 2 ))

    printf "%*s" $padding ""
    printf "%s" "$text"
    printf "\n"
}

# Function to read the contents of a file
read_file() {
    local file="$1"
    local dir="$2"
    file_contents=$(cat "$dir/$file")

    # Calculate the number of lines in the file contents
    # lines=$(echo "$file_contents" | wc -l)
    lines=$(wc -l < "$dir/$file")


    # Get the terminal window size
    term_rows=$(tput lines)

    # Calculate the vertical padding
    vpad=$(( (term_rows - lines) / 2 ))

    # Print vertical padding
    printf "\n%.0s" $(seq 1 $vpad)

    # Print each line centered horizontally
    echo "$file_contents" | while read -r line; do
        center_text "$line"
    done

    # Print vertical padding
    printf "\n%.0s" $(seq 1 $vpad)
}

# Loop through the text chunks
while true; do
    # Clear the screen
    clear

    # Print files from the cursor directory
    for file in "$cursor_dir"/*.txt; do
        read_file "$(basename "$file")" "$cursor_dir"
        sleep 0.2 # Adjust the delay as needed
    done

    # Print files from the module directory
    for file in "$module_dir"/*.txt; do
        read_file "$(basename "$file")" "$module_dir"
        sleep 0.1 # Adjust the delay as needed
    done
    
    # Print files from the mask directory
    for file in "$mask_dir"/*.txt; do
        read_file "$(basename "$file")" "$mask_dir"
        sleep 0.1 # Adjust the delay as needed
    done
    
    # Print files from the mask directory
    for file in "$rmmask_dir"/*.txt; do
        read_file "$(basename "$file")" "$rmmask_dir"
        sleep 0.2 # Adjust the delay as needed
    done

    # Print files from the cursor directory
    for file in "$cursor_dir"/*.txt; do
        read_file "$(basename "$file")" "$cursor_dir"
        sleep 0.2 # Adjust the delay as needed
    done

    # Print files from the cursor directory
    for file in "$system_dir"/*.txt; do
        read_file "$(basename "$file")" "$system_dir"
        sleep 0.2 # Adjust the delay as needed
    done
    break
done