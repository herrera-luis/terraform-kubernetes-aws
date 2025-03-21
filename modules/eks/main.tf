locals {
  environment = "dev"
  tfenvfile   = "${path.module}/config/values.json"
  tfenv       = jsondecode(file(local.tfenvfile))
}

module "eks" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-eks.git?ref=v18.20.2"

  cluster_name                    = var.cluster_name
  cluster_version                 = local.tfenv.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true
  cluster_service_ipv4_cidr       = local.tfenv.cluster_service_ipv4_cidr

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type  = "AL2_ARM_64"
    disk_size = 50
  }

  eks_managed_node_groups = {
    main = {
      min_size     = 1
      max_size     = 4
      desired_size = 2

      instance_types = ["t4g.small"]
      capacity_type  = "SPOT"
      labels = {
        Environment = "dev"
      }
    }
  }


  aws_auth_roles = [for role in local.tfenv.admin_roles :
    {
      rolearn  = role.arn
      username = role.name,
      // This group is built-in to k8s. It is an "admin" group. They can do anything in
      // the cluster. Add with EXTREME caution
      groups = role.groups
    }
  ]

  aws_auth_users = [for user in local.tfenv.admin_users :
    {
      userarn  = user.arn
      username = user.name,
      // This user is built-in to k8s. It is an "admin" user. They can do anything in
      // the cluster. Add with EXTREME caution
      groups = user.groups
    }
  ]

  tags = local.tfenv.tags
}


######################################################################
# Config
######################################################################

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  alias                  = "_internal"
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

######################################################################
# Namespaces
######################################################################

resource "kubernetes_namespace" "namespaces" {
  for_each = local.tfenv.cluster_namespaces
  metadata {
    name        = each.key
    annotations = lookup(each.value, "annotations", {})
    labels      = lookup(each.value, "labels", {})
  }
  provider = kubernetes._internal
}
