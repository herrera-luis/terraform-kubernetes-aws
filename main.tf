module "main-vpc" {
  source = "./modules/vpc"
}

module "main-eks" {
  source       = "./modules/eks"
  cluster_name = "lh-dev-cluster"
  vpc_id       = module.main-vpc.vpc.vpc_id
  subnet_ids   = module.main-vpc.vpc.private_subnet_ids
}
