terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<= 3.37.0"
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
  bucket_name = var.s3_bucket_name
}


module "sync" {
  source         = "./src/sync"
  function_name  = "scheduled-lambda-meta"
  source_bucket  = var.source_bucket
  target_bucket = var.s3_bucket_name
}