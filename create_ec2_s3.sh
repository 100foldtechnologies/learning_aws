#!/bin/bash

# Variables
INSTANCE_TYPE="t2.micro"
AMI_ID="ami-04b4f1a9cf54c11d0"  # Replace with your desired AMI ID
KEY_NAME="Harold-O-key"        # Replace with your key pair name
SECURITY_GROUP_ID="sg-0f1bc090f61fd305e"  # Replace with your security group ID
SUBNET_ID="subnet-0556323d5aa985e16"      # Replace with your subnet ID

# Create EC2 Instances
for i in {1..3}; do
    echo "Creating EC2 instance $i..."
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SECURITY_GROUP_ID \
        --subnet-id $SUBNET_ID \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=MyInstance$i}]" \
        --query 'Instances[0].InstanceId' \
        --output text)

    echo "Waiting for instance $i to be in 'running' state..."
    aws ec2 wait instance-running --instance-ids $INSTANCE_ID

    # Get Public IP of the Instance
    PUBLIC_IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text)

    echo "EC2 Instance $i created with ID: $INSTANCE_ID"
    echo "Public IP: $PUBLIC_IP"
done