terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: Uncomment this once you have your S3 bucket ready
  # backend "s3" {
  #   bucket         = "your-terraform-state-bucket"
  #   key            = "dev/vpc.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-lock"
  # }
}

provider "aws" {
  region = "us-east-1"
}
