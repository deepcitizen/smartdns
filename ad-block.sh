#!/bin/bash
ADBLOCK_DIR="/adblock/repository"
TARGET_DIR="$ADBLOCK_DIR/domains"
OUTPUT_FILE="/adblock/result.tpl"

mkdir $ADBLOCK_DIR
cd $ADBLOCK_DIR
git init
git remote add -f origin https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist.git
git config core.sparseCheckout true
echo "domains/" >> .git/info/sparse-checkout

git pull origin master

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