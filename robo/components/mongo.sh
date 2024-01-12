#!/bin/bash

ID=$(id -u)
LOGFILE="/tmp/mongo.logs"

if [ $ID -ne 0 ] ; then
    echo -e "\e[31m You should execute this script as root user or with a sudo as prefix  \e[0m"
    exit 1
fi

status() {
    if [$1 eq 0] ; then
        echo -e "\e[32m Sucess \e[0m"
    else
        echo -e "\e[31m Failure \e[0m"
        exit 2
    fi
}

echo -n "Configuring the mongodb repo :"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
status $?

echo -n "Installing the mongo : "
yum install -y mongodb-org  &>> $LOGFILE
status $?

echo -n "Starting mongo : "
systemctl enable mongod   &>> $LOGFILE
systemctl start mongod
status $?

echo -n "Updating IP address : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
status $?

echo -n "Restarting Service : "
systemctl daemon-reload
systemctl restart mongod
status $?

echo -n "Downloading the schema : "
curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"   &>> $LOGFILE
status $?

echo -n "Unzipping the downloaded schema : "
cd /tmp
unzip mongodb.zip &>> $LOGFILE
status $?

echo -n "Injecting the schema : "
cd mongodb-main
mongo < catalogue.js  &>> $LOGFILE
mongo < users.js  &>> $LOGFILE
status $?

