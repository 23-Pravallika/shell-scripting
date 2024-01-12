#!/bin/bash

#echo "Iam frontend :"

#set -e

ID=$(id -u)
LOGFILE="/tmp/frontend.logs"

if [ $ID -ne 0 ] ; then
    echo -e "\e[31m You should execute this script as root user or with a sudo as prefix  \e[0m"
fi

status() {
    
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Success \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
fi
}

echo "Installing nginx : "
yum install nginx -y   &>> $LOGFILE
status $?
systemctl enable nginx  &>> $LOGFILE
systemctl start nginx   &>> $LOGFILE
status $?


echo "downloading content :"
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"  &>> $LOGFILE
status $?

echo "Cleaning and deploying :"
cd /usr/share/nginx/html
rm -rf *     
unzip /tmp/frontend.zip  &>> $LOGFILE
mv frontend-main/* .       
mv static/* .
rm -rf frontend-main README.md   
mv localhost.conf /etc/nginx/default.d/roboshop.conf    
status $?


echo "restarting the service :"
systemctl daemon-reload
systemctl restart nginx
status $?

