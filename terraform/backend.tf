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