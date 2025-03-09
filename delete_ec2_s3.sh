#!/bin/bash

# Find and terminate EC2 instances with the tag "Name=MyInstance*"
echo "Finding instances with the tag 'Name=MyInstance*'..."
INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=MyInstance*" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

if [ -z "$INSTANCE_IDS" ]; then
    echo "No instances found with the tag 'Name=MyInstance*'."
    exit 0
fi

echo "Terminating instances: $INSTANCE_IDS"
aws ec2 terminate-instances --instance-ids $INSTANCE_IDS

echo "Waiting for instances to be terminated..."
aws ec2 wait instance-terminated --instance-ids $INSTANCE_IDS

echo "Instances terminated successfully."