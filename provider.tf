terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }

  backend "s3" {
    bucket = "terraform-gitlab-automation-bucket"
    key = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-gitlab-automation-dynamodb-table"
  }
}

provider "aws" {
  region = "us-east-1"
}