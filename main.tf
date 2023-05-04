terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

module "aws-three-tier-network" {
  source              = "./modules/aws-three-tier-network"
  vpc_cidr            = "10.0.0.0/16"
  bastion_access_cidr = "0.0.0.0/0"
}

resource "random_password" "db_password" {
  length  = 20
  special = false
}

module "aws-three-tier-db" {
  source                  = "./modules/aws-three-tier-db"
  db_name                 = "wordpress"
  db_instance_class       = "db.t3.micro"
  db_username             = "wordpress"
  db_password             = random_password.db_password.result
  db_storage_size         = 10
  backup_retention_period = 1
  db_subnets              = module.aws-three-tier-network.subnets_db_tier
  db_security_group       = module.aws-three-tier-network.sg_db_tier
  azs                     = module.aws-three-tier-network.azs
}

module "aws-three-tier-compute" {
  source                  = "./modules/aws-three-tier-compute"
  ubuntu_version          = "22.04"
  ssh_public_key          = file("./ssh/bastion.pub")
  bastion_instance_type   = "t3.micro"
  subnets_web_tier        = module.aws-three-tier-network.subnets_web_tier
  sg_bastion              = module.aws-three-tier-network.sg_bastion
}
