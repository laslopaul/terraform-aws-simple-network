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
  source                    = "./modules/aws-three-tier-compute"
  ubuntu_version            = "22.04"
  ssh_public_key            = file("./.ssh/bastion.pub")
  bastion_instance_type     = "t3.micro"
  sg_bastion                = module.aws-three-tier-network.sg_bastion
  web_tier_instance_type    = "t3.micro"
  web_tier_min_nodes        = 1
  web_tier_max_nodes        = 2
  web_tier_desired_capacity = 2
  subnets_web_tier          = module.aws-three-tier-network.subnets_web_tier
  sg_web_tier               = module.aws-three-tier-network.sg_web_tier
  app_tier_instance_type    = "t3.micro"
  app_tier_min_nodes        = 1
  app_tier_max_nodes        = 2
  app_tier_desired_capacity = 2
  subnets_app_tier          = module.aws-three-tier-network.subnets_app_tier
  sg_app_tier               = module.aws-three-tier-network.sg_app_tier
}

module "aws-three-tier-loadbalancer" {
  source                        = "./modules/aws-three-tier-loadbalancer"
  vpc_id                        = module.aws-three-tier-network.vpc_id
  web_nodes_asg                 = module.aws-three-tier-compute.web_nodes_asg
  external_lb_tg_protocol       = "HTTP"
  external_lb_tg_port           = 80
  external_lb_listener_protocol = "HTTP"
  external_lb_listener_port     = 80
  external_lb_sg                = module.aws-three-tier-network.sg_external_lb
  external_lb_subnets           = module.aws-three-tier-network.subnets_web_tier
  app_nodes_asg                 = module.aws-three-tier-compute.app_nodes_asg
  internal_lb_tg_protocol       = "HTTP"
  internal_lb_tg_port           = 80
  internal_lb_listener_protocol = "HTTP"
  internal_lb_listener_port     = 80
  internal_lb_sg                = module.aws-three-tier-network.sg_internal_lb
  internal_lb_subnets           = module.aws-three-tier-network.subnets_app_tier
}
