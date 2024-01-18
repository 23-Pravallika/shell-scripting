#!/bin/bash

COMPONENT=$1

Image_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')

echo -n "starting the server :"

#running the instance without mentioning the instance name :
# aws ec2 run-instances --image-id $Image_ID --instance-type t2.micro | jq

#running the instance with the instance name :
aws ec2 run-instances  --image-id $Image_ID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=$Image_ID,Value=$COMPONENT}]"  | jq

