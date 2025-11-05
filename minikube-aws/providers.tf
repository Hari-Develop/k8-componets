terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "aws-terraform-remote-stat"
    key = "minikube/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "aws-terraform-locking"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
