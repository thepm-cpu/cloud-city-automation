# Cloud Provider
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    # Will be configured in GitHub Actions
  }
}

provider "aws" {
  region = var.region
}

# 🏡 Build the Estate
module "vpc" {
  source = "../../modules/vpc"
  
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                 = var.azs
  environment         = var.environment
}

# 🚧 Build the Fences
module "security" {
  source = "../../modules/security"
  
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip
}

# 🪪 Create ID Cards
module "iam" {
  source = "../../modules/iam"
}

# 🏠 Build the Houses
module "compute" {
  source = "../../modules/compute"
  
  app_security_group_id        = module.security.app_sg_id
  monitoring_security_group_id = module.security.monitoring_sg_id
  public_subnet_ids           = module.vpc.public_subnet_ids
  key_name                    = var.key_name
  app_instance_type           = var.app_instance_type
  monitoring_instance_type    = var.monitoring_instance_type
}

# 🚦 Deploy Traffic Police
module "load_balancer" {
  source = "../../modules/load_balancer"
  
  vpc_id               = module.vpc.vpc_id
  alb_security_group_id = module.security.alb_sg_id
  public_subnet_ids    = module.vpc.public_subnet_ids
}

# 👷 Deploy Emergency Builders
module "auto_scaling" {
  source = "../../modules/auto_scaling"
  
  public_subnet_ids    = module.vpc.public_subnet_ids
  launch_template_id   = module.compute.app_launch_template_id
  target_group_arn     = module.load_balancer.target_group_arn
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
}

# Outputs for Ansible and GitHub Actions
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_dns_name" {
  value = module.load_balancer.alb_dns_name
}

output "monitoring_server_ip" {
  value = module.compute.monitoring_server_ip
}

output "app_security_group_id" {
  value = module.security.app_sg_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}