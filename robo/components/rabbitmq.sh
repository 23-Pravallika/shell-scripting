#!/bin/bash

COMPONENT=rabbitmq
source COMPONENT/common.sh

echo -n "Installing Erlang :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>> $LOGFILE
status $?

echo -n "YUM repositories for RabbitMQ :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> $LOGFILE
status $?

echo -n "Installing Rabbitmq :"
yum install rabbitmq-server -y  &>> $LOGFILE
status $?

echo -n "Starting RabbitMQ :"
systemctl enable rabbitmq-server    &>> $LOGFILE
systemctl restart rabbitmq-server
status $?

rabbitmqctl list_users | grep $APPUSER  &>> $LOGFILE
if [ $? -ne 0 ] ; then
    echo echo -n "Creating $COMPONENT Application User :"
    rabbitmqctl add_user roboshop roboshop123   &>> $LOGFILE
    status $?
fi

echo -n "Adding required privileges to the $APPUSER :"
rabbitmqctl set_user_tags roboshop administrator    &>> $LOGFILE
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"    &>> $LOGFILE
status $?

