#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-05ab5066195a562b8" # replace with your SG ID
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z03468932B7WI1KW96CYF" # replace with your ZONE ID
DOMAIN_NAME="daws-shankran.site" # replace with your domain

for instance in ${INSTANCES[@]}
#for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.
    micro --security-group-ids sg-01bc7ebe005fb1cb2 --tag-specifications
     "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].
     InstanceId" --output text)
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].
        Instances[0].PrivateIpAddress" --output text)

    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].
        Instances[0].PublicIpAddress" --output text)
    fi
    echo "$instance IP address: $IP"
done