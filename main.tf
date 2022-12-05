terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}

provider "aws" {
#   region = var.aws_region
#   # shared_config_files = ["/Users/jamescheney/.aws/config"]
#   # shared_credentials_files = ["/Users/jamescheney/.aws/credentials"]
#   # profile = "personal-aws"
}

module "aws_vpc" {
  source             = "./modules/vpc"
  availability_zones = ["us-east-1a", "us-east-1b"]
  env                = var.env
  cidr_block         = "10.1.0.0/16"
}


module "aws_security_groups" {
  source = "./modules/security-groups"
  env    = var.env
}


module "aws_ec2" {
  source            = "./modules/ec2"
  ec2_instance_type = var.ec2_instance_type
  ec2_volume_size   = var.ec2_volume_size
  ec2_volume_type   = var.ec2_volume_type
  ec2_public_key    = var.aws_key_pair
}


data "aws_caller_identity" "current" {}
locals {
  account_id = data.aws_caller_identity.current.account_id
}
output "account_id" {
  value = local.account_id
}

module "aws_s3" {
  source      = "./modules/s3"
  bucket_name = "${local.account_id}-${var.aws_region}-${var.env}-bucket"
}

module "aws_autoscaling" {
  source            = "./modules/autoscaling-group+alb"
  env               = var.env
  ec2_instance_type = var.asg_instance_type
  ec2_volume_size   = var.asg_volume_size
  ec2_volume_type   = var.asg_volume_type
  ec2_public_key    = var.aws_key_pair
  asg_max_size      = var.asg_max_size
  asg_min_size      = var.asg_min_size
}
