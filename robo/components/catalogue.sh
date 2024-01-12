#!/bin/bash

ID=$(id -u)
LOGFILE="/tmp/catalogue.logs"
APPUSER=roboshop


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
curl --silent --location https://rpm.nodesource.com/setup_16.x | bash - &>> $LOGFILE
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


echo -n "Downloading the catalogue component :"
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"  &>> $LOGFILE
status $?



echo -n "Extracting the catalogue :"
cd /home/roboshop
unzip -o /tmp/catalogue.zip   &>> $LOGFILE
mv catalogue-main catalogue
status $?



echo -n "Installing the dependencies :"
cd /home/roboshop/catalogue
npm install  &>> $LOGFILE
status $?



echo -n "IP address Upate :"
sed -i -e 's/MONGO_DNSNAME/172.31.31.62/' /home/roboshop/catalogue/systemd.service  &>> $LOGFILE
status $?



echo -n "Starting the catalogue :"
mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue  &>> $LOGFILE
systemctl status catalogue -l
status $?
