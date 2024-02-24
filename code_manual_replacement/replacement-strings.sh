#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <search_string> <replace_string>"
    exit 1
fi

# Assign arguments to variables
SEARCH_STRING="$1"
REPLACE_STRING="$2"
FOLDER="../tsv" # Specify the folder containing the TSV files
CSV_FILE="replaced_strings.csv"

echo pwd

# Create or append to the CSV file with the header if it doesn't exist
if [ ! -f "$CSV_FILE" ]; then
    echo "Original String,Replaced String,Count" > "$CSV_FILE"
fi

# Initialize total count
TOTAL_COUNT=0

# Loop through all TSV files in the specified folder
for file in "$FOLDER"/*.tsv; do
    # Use sed to replace and count the number of replacements made
    COUNT=$(sed -i "s/$SEARCH_STRING/$REPLACE_STRING/g" "$file"; sed -n "s/$SEARCH_STRING/$REPLACE_STRING/gp" "$file" | wc -l)

    # If replacements were made, update the total count and log to CSV
    if [ "$COUNT" -gt 0 ]; then
        TOTAL_COUNT=$((TOTAL_COUNT + COUNT))
        echo "\"$SEARCH_STRING\",\"$REPLACE_STRING\",$COUNT" >> "$CSV_FILE"
    fi
done

echo "Replacement completed. Total replacements made: $TOTAL_COUNT."

# Optionally, you can append the total count to the CSV file or handle it separately.
echo "Total,$TOTAL_COUNT" >> "$CSV_FILE"
