#!/bin/bash

# Set your AWS region
AWS_REGION="ca-central-1"

# Prompt for the bucket name
read -p "Enter the name of the S3 bucket to delete: " BUCKET_NAME

# Check if the bucket name is provided
if [ -z "$BUCKET_NAME" ]; then
  echo "Bucket name is required. Exiting."
  exit 1
fi

# Check if the bucket exists
echo "Checking if bucket '$BUCKET_NAME' exists..."
aws s3api head-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION"

if [ $? -ne 0 ]; then
  echo "Bucket '$BUCKET_NAME' does not exist or you do not have permission to access it."
  exit 1
fi

# List the contents of the bucket (optional)
echo "Listing contents of bucket '$BUCKET_NAME'..."
aws s3 ls "s3://$BUCKET_NAME" --recursive

# Prompt for confirmation
read -p "Are you sure you want to delete the bucket '$BUCKET_NAME' and all its contents? (yes/no): " CONFIRMATION

if [ "$CONFIRMATION" == "yes" ]; then
  # Delete all objects in the bucket
  echo "Deleting all objects in bucket '$BUCKET_NAME'..."
  aws s3 rm "s3://$BUCKET_NAME" --recursive

  # Delete the bucket
  echo "Deleting bucket '$BUCKET_NAME'..."
  aws s3api delete-bucket --bucket "$BUCKET_NAME" --region "$AWS_REGION"

  # Check if the bucket was deleted successfully
  if [ $? -eq 0 ]; then
    echo "Bucket '$BUCKET_NAME' deleted successfully."
  else
    echo "Failed to delete bucket '$BUCKET_NAME'. Please check the bucket name and try again."
    exit 1
  fi
else
  echo "Deletion canceled."
fi