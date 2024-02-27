#!/bin/bash

# Check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <search_string> <replace_string>"
    exit 1
fi

# Assign arguments to variables and escape special characters for sed
SEARCH_STRING=$(printf '%s\n' "$1" | sed 's:[][\/.^$*{}()]:\\&:g')
REPLACE_STRING=$(printf '%s\n' "$2" | sed 's:[\/&]:\\&:g')
FOLDER="../tsv" # Specify the folder containing the TSV files
CSV_FILE="replaced_strings.csv"

# Check for GNU sed vs BSD/macOS sed
if sed --version 2>/dev/null | grep -q GNU; then
    SED_INPLACE=(sed -i)
else
    SED_INPLACE=(sed -i '')
fi

# Create or append to the CSV file with the header if it doesn't exist
if [ ! -f "$CSV_FILE" ]; then
    echo "Original String,Replaced String,Count" > "$CSV_FILE"
fi

# Initialize total count
TOTAL_COUNT=0

# Loop through all TSV files in the specified folder
for file in "${FOLDER}"/*.tsv; do
    # First, count occurrences before replacement
    COUNT_BEFORE=$(grep -o "$SEARCH_STRING" "$file" | wc -l)

    # Perform the replacement
    "${SED_INPLACE[@]}" "s/$SEARCH_STRING/$REPLACE_STRING/g" "$file"

    # Count occurrences after replacement
    COUNT_AFTER=$(grep -o "$REPLACE_STRING" "$file" | wc -l)

    # Calculate the number of replacements made
    let COUNT=COUNT_AFTER-COUNT_BEFORE

    # Update the total count and log to CSV if replacements were made
    if [ "$COUNT" -gt 0 ]; then
        TOTAL_COUNT=$((TOTAL_COUNT + COUNT))
        echo "\"$1\",\"$2\",$COUNT" >> "$CSV_FILE"
    fi
done

echo "Replacement completed. Total replacements made: $TOTAL_COUNT."
