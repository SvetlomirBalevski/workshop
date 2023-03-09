terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  allowed_account_ids = [
    "300989330528",
  ]
}
module "vpc" {
  source                   = "./modules/vpc"
  public_subnet_cidr_block = var.public_subnet_cidr_block
  vpc_cidr_block           = var.public_subnet_cidr_block
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

module "compute" {
  source         = "./modules/compute"
  public_subnet  = module.vpc.public_subnet_id
  security_group = module.security_groups.sg_id
}