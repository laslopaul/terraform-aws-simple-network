terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

module "aws-simple-network" {
  source      = "./modules/aws-simple-network"
  vpc_cidr    = "10.0.0.0/16"
  region      = "eu-west-2"
  environment = "staging"
}

output "vpc_id" {
  description = "VPC identifier"
  value       = module.aws-simple-network.vpc_id
}
