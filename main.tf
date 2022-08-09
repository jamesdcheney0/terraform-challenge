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
    public_subnet_1_id = module.vpc.public_subnet_1_id
    public_subnet_2_id = module.vpc.public_subnet_2_id
    private_subnet_1_id = module.vpc.private_subnet_1_id
    private_subnet_2_id = module.vpc.private_subnet_2_id
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