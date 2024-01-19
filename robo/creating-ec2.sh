#!/bin/bash

# This is a script created to launch EC2 Servers and create the associated Route53 Record 


if [ -z "$1" ] ; then 

    echo -e "\e[31m Component Name is required \e[0m"
    exit

fi

COMPONENT=$1
hostedzone_ID="Z00591173BAPMZJNH5NV7"


AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' | sed -e 's/"//g')
echo  "Ami id is : $AMI_ID "

sg_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=launch-wizard-1 | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')
echo  "Security_group id is : $sg_ID "

echo "Launching the instance with $AMI_ID as AMI :"

#running the instance without mentioning the instance name :
# aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro | jq

#running the instance with the instance name :
IP=$(aws ec2 run-instances  --image-id $AMI_ID \
        --instance-type t2.micro \
        --instance-market-options "MarketType=spot, SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" \
        --security-group-ids ${SGID} \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"  | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

echo "PrivateIpAddresses is : $IP "

sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${IP}/" r53.json  > /tmp/r53.json
aws route53 change-resource-record-sets --hosted-zone-id $hostedzone_ID --change-batch file:///tmp/r53.json