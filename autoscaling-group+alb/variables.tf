variable "ec2_instance_name" {
  description = "Name of the EC2 instance"
  type = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type = string
}

variable "ec2_volume_size" {
  description = "EC2 volume size"
  type = string
}

variable "ec2_volume_type" {
  description = "EC2 volume type"
  type = string
}

variable "ec2_public_key" {
  description = "Public key for SSH access to instance"
  type = string
}

variable "vpc_id" {
  description = "ID of the VPC to be launched in"
  type = string
}

variable "public_subnet_1_id" {
  description = "ID of the first public subnet to be launched in"
  type = string
}

variable "public_subnet_2_id" {
  description = "ID of the second public subnet to be launched in"
  type = string
}

variable "private_subnet_1_id" {
  description = "ID of the first private subnet to be launched in"
  type = string
}

variable "private_subnet_2_id" {
  description = "ID of the second private subnet to be launched in"
  type = string
}
