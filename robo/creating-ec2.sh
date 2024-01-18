#!/bin/bash

# This is a script created to launch EC2 Servers and create the associated Route53 Record 


if [ -z "$1" ] ; then 

    echo -e "\e[31m Component Name is required \e[0m"
    exit

fi

COMPONENT=$1

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo  "Ami id is $AMI_ID  :"

echo -n "Launching the instance with $AMI_ID as AMI :"

#running the instance without mentioning the instance name :
# aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro | jq

#running the instance with the instance name :
aws ec2 run-instances  --image-id $AMI_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"  | jq

