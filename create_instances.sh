#!/bin/bash

# Variables
AMI_ID="ami-055943271915205db"  # Replace with your desired AMI ID
INSTANCE_TYPE="t2.micro"        # Replace with your desired instance type
KEY_NAME="devops"        # Replace with your key pair name
SECURITY_GROUP="sg-008d83511cf3e15b0"     # Replace with your security group ID
REGION="ca-central-1"              # Replace with your desired region
TAG_NAME="EC2Assignment"        #Tag for the EC2 instance
COUNT=3                         # Number of instances to create

# Function to create an instance
create_instance() {
     INSTANCE_ID=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SECURITY_GROUP \
        --region $REGION \
        --output text --query 'Instances[0].InstanceId')
    echo "Created instance with ID: $INSTANCE_ID"
}

# Create instances in parallel
for i in $(seq 1 $COUNT); do
    create_instance &
done

# Wait for all background processes to finish
wait

# Get the public IP of the instances
PUBLIC_IP=$(aws ec2 decribes-instances \
    -- instance-ids "$INSTANCE_ID" \
    --query "Reservation[0].Instances[0].PublicIpAddress" \
    --output text)

if [ "$PUBLIC_IP" == "None" ]; then
  echo "The instance does not have a public IP address."
else
  echo "The public IP address of the instance is: $PUBLIC_IP"
fi

echo "All instances created successfully."