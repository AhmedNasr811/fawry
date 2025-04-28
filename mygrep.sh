#!/bin/bash

# Function to print help message
print_help() {
    echo "Usage: $0 [OPTIONS] search_string filename"
    echo ""
    echo "Options:"
    echo "  -n    Show line numbers for each match"
    echo "  -v    Invert the match (show non-matching lines)"
    echo "  --help  Show this help message"
}

# Check if no arguments provided
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided."
    print_help
    exit 1
fi

# Handle --help
if [ "$1" == "--help" ]; then
    print_help
    exit 0
fi

# Variables
show_line_numbers=false
invert_match=false

# Parse options
while getopts ":nv" opt; do
  case $opt in
    n)
      show_line_numbers=true
      ;;
    v)
      invert_match=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      print_help
      exit 1
      ;;
  esac
done

# Shift parsed options
shift $((OPTIND -1))

# Check remaining arguments
if [ $# -lt 2 ]; then
    echo "Error: Missing search string or filename."
    print_help
    exit 1
fi

search_string="$1"
filename="$2"

# Check if file exists
if [ ! -f "$filename" ]; then
    echo "Error: File '$filename' not found."
    exit 1
fi

# Read file and process lines
line_number=0

while IFS= read -r line; do
    line_number=$((line_number + 1))
    match=false

    # Check case-insensitive match
    if echo "$line" | grep -iq "$search_string"; then
        match=true
    fi

    # Apply invert match if needed
    if $invert_match; then
        match=! $match
    fi

    if $match; then
        if $show_line_numbers; then
            echo "${line_number}:$line"
        else
            echo "$line"
        fi
    fi

done < "$filename"
