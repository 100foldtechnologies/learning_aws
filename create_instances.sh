#!/bin/bash

AMI_ID="ami-04b4f1a9cf54c11d0 " # Replace with the actual AMI ID
INSTANCE_TYPE="t2.micro"
KEY_NAME="class"
SECURITY_GROUP="sg-0cfd85c1d7313334f" # Replaced with my security group
REGION="us-east-1" # Change to your preferred region

aws ec2 run-instances --image-id $AMI_ID --count 2 --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --region $REGION &

aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --region $REGION &

aws ec2 run-instances --image-id $AMI_ID --count 1 --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME --security-group-ids $SECURITY_GROUP --region $REGION &