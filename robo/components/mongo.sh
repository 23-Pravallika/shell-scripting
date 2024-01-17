#!/bin/bash

COMPONENT=mongodb
source components/common.sh

echo -n "Configuring the $COMPONENT repo :"
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
unzip -o mongodb.zip &>> $LOGFILE
status $?

echo -n "Injecting the schema : "
cd mongodb-main
mongo < catalogue.js  &>> $LOGFILE
mongo < users.js  &>> $LOGFILE
status $?

