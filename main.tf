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
}

module "aws_vpc" {
    source = "./vpc"
}

module "aws_security_groups" {
    source = "./security-groups"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}


module "aws_ec2" {
    source = "./ec2"
    ec2_instance_name = var.ec2_instance_name
    ec2_instance_type = var.ec2_instance_type
    ec2_volume_size = var.ec2_volume_size
    ec2_volume_type = var.ec2_volume_type
    ec2_public_key = var.aws_key_pair
    vpc_id = module.vpc.vpc_id
    public_subnet_1_id = module.vpc.public_subnet_1_id
}


data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}
output "account_id" {
  value = local.account_id
}

module "aws_s3" {
    source = "./s3"
    bucket_name = "${local.account_id}-${var.aws_region}-s3_bucket_name"
}

module "aws_autoscaling" {
    source = "./autoscaling-group+alb"
    asg_name = var.asg_name
    ec2_instance_name = var.asg_instance_name
    ec2_instance_type = var.asg_instance_type
    ec2_volume_size = var.asg_volume_size
    ec2_volume_type = var.asg_volume_type
    ec2_public_key = var.aws_key_pair
    vpc_id = module.vpc.vpc_id
    private_subnet_1_id = module.vpc.private_subnet_1_id
    private_subnet_2_id = module.vpc.private_subnet_2_id
    public_subnet_1_id = module.vpc.public_subnet_1_id
    public_subnet_2_id = module.vpc.public_subnet_2_id
}
