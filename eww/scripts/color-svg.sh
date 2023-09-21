#!/bin/bash

# Check for correct number of arguments
if [ "$#" -lt 1 ]; then
	echo "Usage: $0 directory [newString]"
	exit 1
fi

dir="$1"
newString="${2:-$(eww get fg-color)}"

# Iterate over all files in the directory
for file in "$dir"/*; do
	if [[ -f "$file" ]]; then # Ensure it's a file and not a subdirectory or other type
		# Use sed to replace in-place
		sed -i '/fill="none"\|stroke="none"/!s/\(fill\|stroke\)="[^"]*"/\1="'"$newString"'"/g' "$file"
	fi
done

eww reload
echo "Replacement done for all files in $dir."
