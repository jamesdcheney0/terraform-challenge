variable "env" {
  description = "Purpose of the environment"
  type        = string
}
variable "vpc_id" {
  description = "ID of the VPC to be launched in"
  type        = string
}

variable "private_subnets" {
  description = "Subnets the autoscaling group will operate in"
}
variable "public_subnets" {
  description = "Subnets the elastic load balancer will operate in"
}

variable "web_server_sg_id" {
  description = "Web server security group ID"
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}
variable "ec2_volume_size" {
  description = "EC2 volume size"
  type        = string
}
variable "ec2_volume_type" {
  description = "EC2 volume type"
  type        = string
}
variable "ec2_public_key" {
  description = "Public key for SSH access to instance"
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
