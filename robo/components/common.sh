#!/bin/bash

LOGFILE="/tmp/$COMPONENT.logs"
APPUSER=roboshop

ID=$(id -u)
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

CREATE_USER(){

    id $APPUSER  &>> $LOGFILE
    if [ $? -ne 0 ] ; then 
        echo -n "Creating Application user account :"
        useradd roboshop
        status $?
    fi
}


Download_EXTRACT(){
    echo -n "Downloading the $COMPONENT component :"
    curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
    status $? 

    echo -n "Extracting the $COMPONENT in the $APPUSER directory"
    cd /home/$APPUSER 
    rm -rf /home/$APPUSER/$COMPONENT &>> $LOGFILE
    unzip -o /tmp/$COMPONENT.zip  &>> $LOGFILE
    status $? 

    echo -n "Configuring the permissions :"
    mv /home/$APPUSER/$COMPONENT-main  /home/$APPUSER/$COMPONENT
    chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
    status $? 
}

Install_npm(){
    echo -n "Installing the $COMPONENT Application :"
    cd /home/$APPUSER/$COMPONENT
    npm install   &>> $LOGFILE
    status $?
}

CONF_SERVICE(){

    echo -n "Updating the systemd file with DB details :"
    sed -i -e 's/MONGO_DNSNAME/mongo.internal.roboshop/' -e 's/REDIS_ENDPOINT/redis.internal.roboshop/' -e 's/MONGO_ENDPOINT/mongo.internal.roboshop/' -e 's/REDIS_ENDPOINT/redis.internal.roboshop/' -e 's/CATALOGUE_ENDPOINT/catalogue.internal.roboshop/' -e 's/CARTENDPOINT/cart.internal.roboshop/' -e 's/DBHOST/mysql.internal.roboshop/' -e 's/CARTHOST/cart.internal.roboshop/' -e 's/USERHOST/user.internal.roboshop/' -e 's/AMQPHOST/rabbitmq.internal.roboshop/' /home/$APPUSER/$COMPONENT/systemd.service 
    mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
    status $?

    echo -n "Starting the  $COMPONENT Application :"
    systemctl daemon-reload
    systemctl enable $COMPONENT  &>> $LOGFILE
    systemctl restart $COMPONENT 
    status $?
}

Maven_Package(){
    echo -n "Creating the $COMPONENT Package :"
    cd /home/$APPUSER/$COMPONENT/ 
    mvn clean package   &>> $LOGFILE
    mv target/$COMPONENT-1.0.jar $COMPONENT.jar
}


NODEJS(){

    echo -n "Configuring the nodejs repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | bash - &>> $LOGFILE
    status $?

    echo -n "Installing NodeJS :"
    yum install nodejs -y &>> $LOGFILE
    status $?

    #calling the create_user
    CREATE_USER 

    #calling download_extract function
    Download_EXTRACT

    #calling Install_npm function
    Install_npm

    # calling CONF_SERVICE function
    CONF_SERVICE

}

JAVA(){
    echo -n "Installing Maven  :" 
    yum install maven -y  &>> $LOGFILE
    status $?  

    #calling the create_user
    CREATE_USER 

    #calling download_extract function
    Download_EXTRACT

    #calling Maven_Package function
    Maven_Package

    # calling CONF_SERVICE function
    CONF_SERVICE


}

Python(){
    echo -n "Installing Python :"
    status $?

    #calling the create_user
    CREATE_USER

    #calling download_extract function
    Download_EXTRACT

    echo -n "Installing pip :"
    cd /home/roboshop/$COMPONENT/ 
    pip3 install -r requirements.txt    &>> $LOGFILE 
    status $?

    U_ID=$(id -u roboshop)
    G_ID=$(id -g roboshop)

    echo -n "Updating the roboshop user id and group id :"
    sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid/ c gid=${GROUPID}"  /home/$APPUSER/$COMPONENT/$COMPONENT.ini
    status $?

    # calling CONF_SERVICE function
    CONF_SERVICE

}