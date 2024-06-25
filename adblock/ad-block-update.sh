#!/bin/bash
ADBLOCK_DIR="/adblock/repository"
TARGET_DIR="$ADBLOCK_DIR/domains"
OUTPUT_FILE="/dnsmasq/adblock.conf"

cd $ADBLOCK_DIR
git pull origin master

./ad-block.sh

cd ../
docker-compose up --build -d