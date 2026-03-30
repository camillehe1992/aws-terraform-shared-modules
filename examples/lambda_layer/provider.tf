terraform {
  required_version = ">= 1.14.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.35.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  # Default tags to be applied to all resources created by this provider
  default_tags {
    tags = {
      Repository = "aws-terraform-shared-modules"
      ManagedBy  = "terraform"
    }
  }
}
