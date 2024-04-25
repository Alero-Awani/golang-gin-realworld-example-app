provider "aws" {
  region = var.region
}


terraform {
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }

  }

  required_version = "~> 1.0"
}


# Backend Configuration
terraform {  
    backend "s3" {
        bucket         = "alero-tfstate"
        encrypt        = true
        key            = "terraform.tfstate"    
        region         = "us-east-1"
        dynamodb_table = "app-state"
    }
}
