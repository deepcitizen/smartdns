#!/bin/bash
# Clear result file
echo "" > $OUTPUT_FILE

for file in "$TARGET_DIR"/*; do
  # Check file exists and not empty
  if [ -f "$file" ]; then
    while IFS= read -r line || [ -n "$line" ]; do
      # Ignore empty rows
      if [ -n "$line" ]; then
        # Transform row to dnsmasq format
        echo "address=/$line/0.0.0.0" >> $OUTPUT_FILE
      fi
    done < "$file"
  fi
done