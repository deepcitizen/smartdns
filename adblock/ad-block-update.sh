#!/bin/bash
ADBLOCK_DIR="/adblock/repository"
TARGET_DIR="$ADBLOCK_DIR/domains"
OUTPUT_FILE="/adblock/result.tpl"

cd $ADBLOCK_DIR
git pull origin master

./ad-block.sh