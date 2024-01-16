#!/bin/bash

#echo "Iam frontend :"

#set -e
COMPONENT=frontend
ID=$(id -u)
LOGFILE="/tmp/$COMPONENT.logs"

if [ $ID -ne 0 ] ; then
    echo -e  "\e[31m You should execute this script as root user or with a sudo as prefix  \e[0m"
    exit 
fi

status() {
    
    if [ $1 -eq 0 ] ; then
        echo -e  "\e[32m Success \e[0m"
    else
        echo -e  "\e[31m Failure \e[0m"
        exit 
fi
}

echo -n "Installing nginx : "
yum install nginx -y   &>> $LOGFILE
status $?


echo -n "downloading content :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"  &>> $LOGFILE
status $?


echo -n "Cleaning old content:"
cd /usr/share/nginx/html
rm -rf *     
status $?

echo -n "Copying downloaded content :" 
unzip /tmp/$COMPONENT.zip  &>> $LOGFILE
mv $COMPONENT-main/* .       
mv static/* .
rm -rf $COMPONENT-main README.md   
mv localhost.conf /etc/nginx/default.d/roboshop.conf    
status $?


echo -n "starting the service :"
systemctl daemon-reload
systemctl enable nginx  &>> $LOGFILE
systemctl restart nginx
status $?

