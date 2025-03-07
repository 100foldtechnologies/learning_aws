#!/bin/bash

# Set your AWS region
AWS_REGION="ca-central-1"

# Prompt for the bucket name
read -p "Enter the name for your S3 bucket: " BUCKET_NAME

# Check if the bucket name is provided
if [ -z "$BUCKET_NAME" ]; then
  echo "Bucket name is required. Exiting."
  exit 1
fi

# Create the S3 bucket
echo "Creating S3 bucket '$BUCKET_NAME' in region '$AWS_REGION'..."
aws s3api create-bucket \
  --bucket "$BUCKET_NAME" \
  --region "$AWS_REGION" \
  --create-bucket-configuration LocationConstraint="$AWS_REGION"

# Check if the bucket was created successfully
if [ $? -eq 0 ]; then
  echo "S3 bucket '$BUCKET_NAME' created successfully in region '$AWS_REGION'."
else
  echo "Failed to create S3 bucket '$BUCKET_NAME'. Please check the bucket name and try again."
  exit 1
fi