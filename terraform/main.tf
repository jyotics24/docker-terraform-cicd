# Tell Terraform which cloud provider to use
provider "aws" {
  # AWS region where resources will be created
  region = "us-east-1"
}

# Create an S3 bucket
resource "aws_s3_bucket" "bucket" {

  # Bucket name must be globally unique
  # Change this name before running
  bucket = "jyotics24-terraform-s3-12345"

  # Optional tags (good practice)
  tags = {
    Name        = "CI-CD-S3-Bucket"
    Environment = "Dev"
  }
}

# Block all public access to the S3 bucket
# This is AWS best practice for security
resource "aws_s3_bucket_public_access_block" "block" {

  # Attach this policy to the bucket created above
  bucket = aws_s3_bucket.bucket.id

  # Disable all public ACLs and policies
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}