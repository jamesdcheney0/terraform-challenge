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

variable "bastion_sg_id" {
  description = "ID of Bastion security group"
}

variable "public_subnet" {
  description = "ID of public subnet to use"
}
