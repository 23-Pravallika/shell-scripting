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

sg_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=allow-all-sg | jq '.SecurityGroups[].GroupId' | sed -e 's/"//g')
echo  "Security_group id is : $sg_ID "

echo "Launching the instance with $AMI_ID as AMI :"

#running the instance without mentioning the instance name :
# aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro | jq

#running the instance with the instance name :
create_instance() {
     
    echo "*** Launching $COMPONENT Server ***"
    
    IP=$(aws ec2 run-instances  --image-id $AMI_ID \
            --instance-type t2.micro \
            --instance-market-options "MarketType=spot, SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" \
            --security-group-ids ${sg_ID} \
            --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${COMPONENT}}]"  | jq '.Instances[].PrivateIpAddress' | sed -e 's/"//g')

    echo "PrivateIpAddresses is : $IP "

    sed -e "s/COMPONENT/${COMPONENT}/" -e "s/IPADDRESS/${IP}/" r53.json  > /tmp/record.json
    aws route53 change-resource-record-sets --hosted-zone-id $hostedzone_ID --change-batch file:///tmp/record.json

    echo "*** $COMPONENT Server Completed ***"

}

if [ "$1" == "all" ] ; then

    for component in frontend mongodb catalogue cart user mysql redis rabbitmq shipping payment ; do
        COMPONENT=$component 
        create_instance
    done 
    
else
    
    create_instance

fi
