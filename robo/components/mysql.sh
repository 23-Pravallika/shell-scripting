#!/bin/bash

COMPONENT=mysql
source components/common.sh


echo -n "Configuring the $COMPONENT repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo &>> $LOGFILE  
status $?

echo -n "Installing the $COMPONENT :"
yum install mysql-community-server -y   &>> $LOGFILE
status $?

echo -n "Starting the $COMPONENT :"
systemctl enable mysqld &>> $LOGFILE
systemctl start mysqld
status $?

