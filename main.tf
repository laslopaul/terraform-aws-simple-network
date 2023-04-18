terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "aws-three-tier-network" {
  source              = "./modules/aws-three-tier-network"
  vpc_cidr            = "10.0.0.0/16"
  region              = "eu-west-2"
  bastion_access_cidr = "0.0.0.0/0"
  environment         = "staging"
}
