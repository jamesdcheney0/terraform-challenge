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

module "aws_s3" {
    source = "./s3"
}

module "aws_autoscaling" {
    source = "./autoscaling-group"
    asg_name = var.asg_name
    ec2_instance_name = var.asg_instance_name
    ec2_instance_type = var.asg_instance_type
    ec2_volume_size = var.asg_volume_size
    ec2_volume_type = var.asg_volume_type
    ec2_public_key = var.aws_key_pair
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
    private_subnet_1_id = module.vpc.private_subnet_1_id
    private_subnet_2_id = module.vpc.private_subnet_2_id
}

module "aws_alb" {
    source = "./alb"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}