#!/bin/bash

echo "frontend :"
set -e

ID=$(id root)

if [ $ID -ne 0 ]; then
echo "\e[31m You need to be root to perform this command \e[0m"
fi

yum install nginx -y
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx
systemctl start nginx
