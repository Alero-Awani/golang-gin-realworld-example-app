provider "aws" {
  region = var.region
}


terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">=1.14.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">=2.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.45.0"
    }

  }

  required_version = "~> 1.0"
}