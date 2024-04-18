# terraform {
#   backend "s3" {
#     bucket = "tfstate-bucket"
#     key = "state/terraform.tfstate"
#     region = "us-east-1"
#     encrypt = true
#     dynamodb_table = "tf_lockid"
#   }
# }

# resource "aws_s3_bucket" "tfstate-bucket" {
#   bucket = "tfstate-bucket"
# }