#!/bin/bash

# Set AWS region
REGION="us-east-1"

# Fetch instance IDs for running instances
echo "Fetching running EC2 instances..."
INSTANCE_IDS=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" --output text --region $REGION)

# Check if there are instances to terminate
if [ -z "$INSTANCE_IDS" ]; then
    echo "No running instances found."
    exit 0
fi

# Display instances to be terminated
echo "Instances to be terminated: $INSTANCE_IDS"

# Terminate the instances
aws ec2 terminate-instances --instance-ids $INSTANCE_IDS --region $REGION

echo "Termination request sent. Waiting for completion..."

# Wait for termination to complete
aws ec2 wait instance-terminated --instance-ids $INSTANCE_IDS --region $REGION

echo "All instances terminated successfully!"