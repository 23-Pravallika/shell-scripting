#!/bin/bash

Image_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')

echo -n "starting the server :"

aws ec2 run-instances --image-id $Image_ID --instance-type t2.micro