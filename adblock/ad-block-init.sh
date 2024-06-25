#!/bin/bash
ADBLOCK_DIR="/adblock/repository"
TARGET_DIR="$ADBLOCK_DIR/domains"
OUTPUT_FILE="/adblock/result.tpl"

mkdir -p $ADBLOCK_DIR
cd $ADBLOCK_DIR
git init
git remote add -f origin https://github.com/Ultimate-Hosts-Blacklist/Ultimate.Hosts.Blacklist.git
git config core.sparseCheckout true
echo "domains/" >> .git/info/sparse-checkout

git pull origin master

./ad-block.sh

echo "@daily . $(pwd)/ad-block-update.sh" >> /etc/crontab