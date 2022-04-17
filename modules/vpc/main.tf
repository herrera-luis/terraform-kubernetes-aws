
locals {
  environment = "dev"
  tfenvfile   = "${path.module}/config/values.json"
  tfenv       = jsondecode(file(local.tfenvfile))
}


module "vpc" {
  source             = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v3.14.0"
  name               = local.tfenv.vpc_name
  cidr               = local.tfenv.vpc_cidr_block
  azs                = local.tfenv.availability_zones_names_in_region
  private_subnets    = local.tfenv.private_subnets_cidr_blocks
  public_subnets     = local.tfenv.public_subnets_cidr_blocks
  enable_nat_gateway = local.tfenv.enable_nat_gateway
  enable_vpn_gateway = local.tfenv.enable_vpn_gateway
  tags               = local.tfenv.tags
}
