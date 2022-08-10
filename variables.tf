variable "aws_region" {
    description = "AWS region"
    type = string
}
variable "aws_key_pair" {
    description = "Name of the keypair to use in connecting to instances"
    type = string
}


variable "ec2_instance_name" {
    description = "Instance name for EC2 instance"
    type = string
}
variable "asg_instance_name" {
    description = "Instance name for ASG instances"
    type = string
}
variable "asg_name" {
    description = "Name for ASG group"
    type = string
}
variable "s3_bucket_name" {
    description = "Name for S3 bucket"
    type = string
}
variable "web_server_sg_name" {
    description = "Name for web server security group"
    type = string
}
variable "bastion_ssh_sg_name" {
    description = "Name for bastion SSH security group"
    type = string
}
variable "alb_name" {
    description = "Name for the application load balancer"
    type = string
}
variable "alb_tg_name" {
    description = "Name for the target groups for the application load balancer"
    type = string
}



variable "web_server_sg_description" {
    description = "Description for web server security group"
    type = string
}
variable "bastion_ssh_sg_description" {
    description = "Description for bastion SSH security group"
    type = string
}



variable "ec2_instance_type" {
    description = "Instance type for EC2 instance"
    type = string
}
variable "asg_instance_type" {
    description = "Instance type for ASG instances"
    type = string
}


variable "ec2_volume_size" {
    description = "Instance volume size for EC2 instance"
    type = string
}
variable "asg_volume_size" {
    description = "Instance volume size for ASG instances"
    type = string
}



variable "ec2_volume_type" {
    description = "Instance volume type for EC2 instances"
    type = string
}
variable "asg_volume_type" {
    description = "Instance volume type for ASG instances"
    type = string
}



variable "asg_max_size" {
  description = "Maximum desired quantity of autoscaled instances"
  type = string
}
variable "asg_min_size" {
  description = "Minimum desired quantity of autoscaled instances"
  type = string
}
