terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.16.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  shared_config_files = ["~/.aws/config"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile = "personal-aws"
}

module "aws_vpc" {
    source = "./modules/vpc"
}


module "aws_security_groups" {
    source = "./modules/security-groups"
    vpc_id = module.aws_vpc.vpc_id
    web_server_sg_name = var.web_server_sg_name
    bastion_ssh_sg_name = var.bastion_ssh_sg_name
    web_server_sg_description = var.web_server_sg_description
    bastion_ssh_sg_description = var.bastion_ssh_sg_description
}


module "aws_ec2" {
    source = "./modules/ec2"
    ec2_instance_name = var.ec2_instance_name
    ec2_instance_type = var.ec2_instance_type
    ec2_volume_size = var.ec2_volume_size
    ec2_volume_type = var.ec2_volume_type
    ec2_public_key = var.aws_key_pair
    vpc_id = module.aws_vpc.vpc_id
    public_subnet_1_id = module.aws_vpc.public_subnet_1_id
    bastion_ssh_sg = module.aws_security_groups.bastion_ssh_sg_id
}


data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}
output "account_id" {
  value = local.account_id
}

module "aws_s3" {
    source = "./modules/s3"
    bucket_name = "${local.account_id}-${var.aws_region}-${var.s3_bucket_name}"
}

module "aws_autoscaling" {
    source = "./modules/autoscaling-group+alb"
    asg_name = var.asg_name
    alb_name = var.alb_name
    alb_tg_name = var.alb_tg_name
    ec2_instance_name = var.asg_instance_name
    ec2_instance_type = var.asg_instance_type
    ec2_volume_size = var.asg_volume_size
    ec2_volume_type = var.asg_volume_type
    ec2_public_key = var.aws_key_pair
    asg_max_size = var.asg_max_size
    asg_min_size = var.asg_min_size
    vpc_id = module.aws_vpc.vpc_id
    private_subnet_1_id = module.aws_vpc.private_subnet_1_id
    private_subnet_2_id = module.aws_vpc.private_subnet_2_id
    public_subnet_1_id = module.aws_vpc.public_subnet_1_id
    public_subnet_2_id = module.aws_vpc.public_subnet_2_id
    web_server_sg = module.aws_security_groups.web_server_sg_id
}
