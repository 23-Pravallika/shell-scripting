#!/bin/bash

DOWNLOAD_AND_EXTRACT_SCHEMA() {
    
    echo -n "Downloading the schema : "
    curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"   &>> $LOGFILE
    status $?

    echo -n "Unzipping the downloaded schema : "
    cd /tmp
    unzip -o $COMPONENT.zip &>> $LOGFILE
    status $?
}


