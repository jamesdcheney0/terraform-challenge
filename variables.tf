variable "aws_region" {
  description = "AWS region"
  type        = string
}
variable "aws_key_pair" {
  description = "Name of the keypair to use in connecting to instances"
  type        = string
}

variable "env" {
  description = "What is the purpose of the environment?"
  type        = string
}



variable "ec2_instance_type" {
  description = "Instance type for EC2 instance"
  type        = string
}
variable "asg_instance_type" {
  description = "Instance type for ASG instances"
  type        = string
}


variable "ec2_volume_size" {
  description = "Instance volume size for EC2 instance"
  type        = string
}
variable "asg_volume_size" {
  description = "Instance volume size for ASG instances"
  type        = string
}



variable "ec2_volume_type" {
  description = "Instance volume type for EC2 instances"
  type        = string
}
variable "asg_volume_type" {
  description = "Instance volume type for ASG instances"
  type        = string
}



variable "asg_max_size" {
  description = "Maximum desired quantity of autoscaled instances"
  type        = string
}
variable "asg_min_size" {
  description = "Minimum desired quantity of autoscaled instances"
  type        = string
}
