#!/bin/bash
read -p "Enter server domain: " SERVER_DOMAIN
read -p "Enter email: " CERT_EMAIL

apt install certbot -y
certbot certonly --standalone --preferred-challenges http --agree-tos --email $CERT_EMAIL -d $SERVER_DOMAIN

echo "@daily certbot renew --quiet" >> /etc/crontab