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
yum install https://rpm.nodesource.com/pub_16.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y  &>> $LOGFILE
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

echo -n "Downloading the content :" 
curl -s -L -o /tmp/catalogue.zip "https://github.com/stans-robot-project/catalogue/archive/main.zip"  &>> $LOGFILE
stat $?

echo -n "Extracting the content :"
cd /home/$APPUSER                  &>> $LOGFILE
rm -rf /home/$APPUSER/$COMPONENT   &>> $LOGFILE
unzip -o /tmp/catalogue.zip        &>> $LOGFILE
stat $?

echo -n "Configuring the permissions :"
mv /home/$APPUSER/$COMPONENT-main  /home/$APPUSER/$COMPONENT
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
status $?

echo -n "Installing the $COMPONENT Application :"
cd /home/$APPUSER/$COMPONENT
npm install   &>> $LOGFILE
status $?


echo -n "Updating the systemd file with DB details :"
sed -i -e 's/MONGO_DNSNAME/172.31.83.172/' /home/$APPUSER/$COMPONENT/systemd.service
status $?


echo -n "Starting the  $COMPONENT Application :"
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
systemctl daemon-reload
systemctl enable $COMPONENT  &>> $LOGFILE
systemctl start $COMPONENT
status $?
