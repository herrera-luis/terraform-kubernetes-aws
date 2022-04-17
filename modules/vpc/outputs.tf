output "vpc" {
  value = {
    vpc_id                     = module.vpc.vpc_id
    vpc_arn                    = module.vpc.vpc_arn
    vpc_cidr_block             = module.vpc.vpc_cidr_block
    private_subnet_ids         = module.vpc.private_subnets
    private_subnet_arns        = module.vpc.private_subnet_arns
    private_subnet_cidr_blocks = module.vpc.private_subnets_cidr_blocks
    public_subnet_ids          = module.vpc.public_subnets
    public_subnet_arns         = module.vpc.public_subnet_arns
    public_subnet_cidr_blocks  = module.vpc.public_subnets_cidr_blocks
    internet_gateway_id        = module.vpc.igw_id
    internet_gateway_arn       = module.vpc.igw_arn
    nat_gateway_ids            = module.vpc.natgw_ids
    public_route_table_ids     = module.vpc.public_route_table_ids
    private_route_table_ids    = module.vpc.private_route_table_ids
    public_network_acl_ids     = module.vpc.public_network_acl_id
    public_network_acl_arns    = module.vpc.public_network_acl_arn
    private_network_acl_ids    = module.vpc.private_network_acl_id
    private_network_acl_arns   = module.vpc.private_network_acl_arn
  }
}
