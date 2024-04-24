# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "18.29.0"

#   cluster_name    = var.cluster_name
#   cluster_version = var.cluster_version

#   cluster_endpoint_private_access = true
#   cluster_endpoint_public_access  = true

#   vpc_id     = module.vpc.vpc_id
#   subnet_ids = module.vpc.private_subnets


#   enable_irsa = true

#   eks_managed_node_group_defaults = {
#     disk_size = 50
#   }

#   eks_managed_node_groups = {
#     general = {
#       desired_size = 2
#       min_size     = 2
#       max_size     = 3

#       labels = {
#         role = "general"
#       }

#       instance_types = ["t3.small"]
#       capacity_type  = "ON_DEMAND"
#     }


#     # spot = {
#     #   desired_size = 1
#     #   min_size     = 1
#     #   max_size     = 10

#     #   labels = {
#     #     role = "spot"
#     #   }

#     #   taints = [{
#     #     key    = "market"
#     #     value  = "spot"
#     #     effect = "NO_SCHEDULE"
#     #   }]

#     #   instance_types = ["t3.micro"]
#     #   capacity_type  = "SPOT"
#     # }

#   }

#   # node_security_group_additional_rules = {
#   #   ingress_allow_access_from_control_plane = {
#   #     type                          = "ingress"
#   #     protocol                      = "tcp"
#   #     from_port                     = 9443
#   #     to_port                       = 9443
#   #     source_cluster_security_group = true
#   #     description                   = "Allow access from control plane to webhook port of AWS load balancer"
#   #   }
#   # }

#   tags = {
#     Environment = "dev"
#   }


#   # manage_aws_auth_configmap = true

#   # aws_auth_roles = [
#   #   {
#   #     rolearn  = module.eks_admins_iam_role.iam_role_arn
#   #     username = module.eks_admins_iam_role.iam_role_name
#   #     groups   = ["system:masters"]
#   #   },
#   # ]


# }


# data "aws_eks_cluster" "default" {
#   name = module.eks.cluster_id
# }

# data "aws_eks_cluster_auth" "default" {
#   name = module.eks.cluster_id
# }

# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.default.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
#     command     = "aws"
#   }
# }

# data "aws_eks_node_group" "node_group" {
#   cluster_name = module.eks.cluster_name
#   node_group_name = "general"
# }

# locals {
#   general_node_ips = data.aws-eks_managed_node_group.general.instances[*].private_ip
# }

# resource "local_file" "inventory" {
#   filename = "../ansible/inventory"
#   content = templatefile("ansible_inventory.tftpl", {
#     node_ips = local.general_node_ips
#   })
#   depends_on = [ module.eks ]
# }


# resource "tls_private_key" "tls_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }
# resource "aws_key_pair" "my_auth" {
#   key_name   = var.my_key
#   public_key = tls_private_key.tls_key.public_key_openssh

#     provisioner "local-exec" {   
#     command = <<-EOT
#       chmod 600 ${path.module}/private_key.pem
#     EOT
#   }

# }

# resource "local_sensitive_file" "private_key_output" {
#   content  = tls_private_key.tls_key.private_key_pem
#   filename = "${path.module}/private_key.pem"
# }