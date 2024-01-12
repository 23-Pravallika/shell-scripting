#!/bin/bash

#echo "Iam frontend :"

#set -e

ID=$(id root)
Log=$(&>> /tmp/logs)

if [ $ID -ne 0 ] ; then
    echo -e "\e[31m You need to be root to perform this command \e[0m"
fi

status() {
    
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
fi
}

echo "Installing nginx : "
yum install nginx -y   $Log
status $?
systemctl enable nginx  $Log
systemctl start nginx   $Log
status $?


echo "downloading content :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"  $Log
status $?

echo "Cleaning and deploying :"
cd /usr/share/nginx/html
rm -rf *     $Log
unzip /tmp/frontend.zip  $Log
mv frontend-main/* .       
mv static/* .
rm -rf frontend-main README.md   $Log
mv localhost.conf /etc/nginx/default.d/roboshop.conf    $Log
status $?


echo "restarting the service :"
systemctl daemon-reload
systemctl restart nginx
status $?

