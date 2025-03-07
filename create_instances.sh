#!/bin/bash

AMI_ID="ami-xxxxxxxx" # Replace with the actual AMI ID
INSTANCE_TYPE="t2.micro"
KEY_NAME="my-key"
SECURITY_GROUP="sg-xxxxxxxx" # Replace with your security group
REGION="us-east-1" # Change to your preferred region

aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --region $REGION &

aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --region $REGION &

aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --region $REGION &