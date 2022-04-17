terraform {
  required_version = "~> 1.0.1"
  backend "s3" {
    bucket = "lh-aws-terraform-state"
    key    = "terraform.tfstate.kubernetes-aws"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.48.0"
    }
  }
}
