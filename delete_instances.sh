#!/bin/bash

# Set your AWS region
AWS_REGION="ca-central-1"

# Define the instance IDs of the 3 instances you want to delete
INSTANCE_IDS=("i-050aa6e46b3ef25b7" "i-0961c5b7a316efcea" "i-013d741f21c00d5ab")

# Check if the instance IDs are provided
if [ ${#INSTANCE_IDS[@]} -eq 0 ]; then
  echo "No instance IDs provided. Please update the script with the instance IDs."
  exit 1
fi

# Display the instances that will be deleted
echo "The following instances will be deleted:"
for INSTANCE_ID in "${INSTANCE_IDS[@]}"; do
  echo "$INSTANCE_ID"
done

# Prompt for confirmation
read -p "Are you sure you want to delete these instances? (yes/no): " CONFIRMATION

if [ "$CONFIRMATION" == "yes" ]; then
  # Delete the instances
  aws ec2 terminate-instances --region $AWS_REGION --instance-ids "${INSTANCE_IDS[@]}"
  echo "Instances deletion initiated successfully."
else
  echo "Deletion canceled."
fi