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
    ec2_instance_type = var.ec2_instance_type
    ec2_storage_size = var.ec2_storage_size
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}

module "aws_s3" {
    source = "./s3"
}

module "aws_autoscaling" {
    source = "./autoscaling-group"
    ec2_instance_type = var.asg_instance_type
    ec2_storage_size = var.asg_storage_size
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}

module "aws_alb" {
    source = "./alb"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}