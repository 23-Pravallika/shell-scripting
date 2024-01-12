#!/bin/bash

ID=$(id -u)
LOGFILE="/tmp/catalogue.logs"
APPUSER=roboshop
COMPONENT=catalogue


if [ $ID -ne 0 ] ; then
    echo -e "\e[31m You should execute this script as root user or with a sudo as prefix \e[0m"
    exit
fi

status() {
    if [ $1 -eq 0 ] ; then
        echo -e "\e[32m Sucess \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
        exit
    fi
}

echo -n "Configuring the nodejs repo :"
curl -sL https://rpm.nodesource.com/setup_8.x | sudo bash - &>> $LOGFILE
stat $?  


echo -n "Installing NodeJS :"
yum install nodejs -y &>> $LOGFILE
stat $?


id $APPUSER &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo -n "Creating Application user account :"
    useradd roboshop
    status $?
fi


echo -n "Configuring the permissions :"
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
status $?



