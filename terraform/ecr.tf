resource "aws_ecr_repository" "ecr" {
  name                 = "ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}


# resource "aws_ecr_repository_policy" "ecr_policy" {
#   repository = aws_ecr_repository.ecr_repo.name
#   policy = jsondecode({
#     version = "2008-10-17"
#     statement = [
#       {
#         sid       = "AllowPull"
#         effect    = "Allow"
#         principal = "*"
#         action = [
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:BatchGetImage",
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:PutImage",
#           "ecr:InitiateLayerUpload",
#           "ecr:UploadLayerPart",
#           "ecr:CompleteLayerUpload",
#           "ecr:DescribeRepositories",
#           "ecr:GetRepositoryPolicy",
#           "ecr:ListImages",
#           "ecr:DeleteRepository",
#           "ecr:BatchDeleteImage",
#           "ecr:SetRepositoryPolicy",
#           "ecr:DeleteRepositoryPolicy",

#         ]
#       }
#     ]
#   })
# }


