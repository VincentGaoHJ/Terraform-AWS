terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.0.1"
    }
  }
  required_version = ">= 1.1.0"
  cloud {
    organization = "meta-vincent"
    workspaces {
      name = "Terraform-AWS"
    }
  }
}

provider "aws" {
  region = var.region
}

module "s3" {
  source      = "./src/s3"
  bucket_name = "meta-trading-vincent-s3-bucket-demo" # bucket name should be unique
}


