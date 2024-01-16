#!/bin/bash

COMPONENT=redis
source components/common.sh

echo -n "Configuring the redis repo :"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo  &>> $LOGFILE
status $?

echo -n "Installing the redis :"
yum install redis-6.2.13 -y &>> $LOGFILE
status $?

echo -n "Updating the $COMPONENT visibility : "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
status $?

echo -n "Starting the Redis DB :"
systemctl daemon-reload 
systemctl enable $COMPONENT  &>> $LOGFILE
systemctl start $COMPONENT
status $?
