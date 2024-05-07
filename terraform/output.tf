# output "private_key" {
#   value     = tls_private_key.tls_key.private_key_pem
#   sensitive = true
# }

output "cluster_id" {
    value = module.eks.cluster_id
}
output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
}

output "repository_url" {
  value = aws_ecr_repository.ecr.repository_url
}

