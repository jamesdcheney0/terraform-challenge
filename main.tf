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

resource "aws_key_pair" "ec2_access" {
  key_name = "ec2-access"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQD0tGAXzEy82bVIb+6UjUD7Jvb8LnSK6PH5sG4E2mWbijEvdxElnFtvvMm1JwLxwKNfT9mDxyFd+xw/mwAmymhgvIAbN1LjB/GTVLskcfsKC6E9A8fhtgVZsmeXQYaxFw/h6ogUWpp3mFf0DWUcpjvsMH1Zokmi4/Coyy9nhR+jWiu4nP9AlgTkQSsGLylH+J4IQe/mZBmjSI0EPWidtQ+vqwtTaU90mszLBAIioIE/gBGfcdj1De3mighVxW4AL0tm3X0+l2u3EdcL2Ex1OV1W5lLiyB2JOyqVORHRegNKzKm85M5i6vlY9biMd/RzurYXpjuqqHsKH9USxgXfxF6iEJrun8Hd0yCv4OFLAfvno5L74W/7JaVqLo8xyaJrtmCcxk28K3cv8HQHM76iBNtSpCuVojsDJK0PLy8cNQ0JuMQ9nS+Tf4qD4UT6/bzH2NRWKf8abdtcbpux7s2B8Az7xDYQZm6vf//wABpx/4DjjnaQURLvRu6CnZ4wunkAIMM= jimmycheney@Jimmys-MacBook-Air.local"
}

module "aws_ec2" {
    source = "./ec2"
    ec2_instance_name = var.ec2_instance_name
    ec2_instance_type = var.ec2_instance_type
    ec2_volume_size = var.ec2_volume_size
    ec2_volume_type = var.ec2_volume_type
    vpc_id = module.vpc.vpc_id
    public_subnet_1_id = module.vpc.public_subnet_1_id
}

module "aws_s3" {
    source = "./s3"
}

module "aws_autoscaling" {
    source = "./autoscaling-group"
    asg_instance_name = var.asg_instance_name
    ec2_instance_type = var.asg_instance_type
    ec2_volume_size = var.asg_volume_size
    ec2_volume_type = var.asg_volume_type
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id

    public_subnet_2_id = module.vpc.public_subnet_2_id
    private_subnet_1_id = module.vpc.private_subnet_1_id
    private_subnet_2_id = module.vpc.private_subnet_2_id
}

module "aws_alb" {
    source = "./alb"
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}