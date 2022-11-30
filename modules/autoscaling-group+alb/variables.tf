variable "env" {
  description = "What is the purpose of the environment?"
  type        = string
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
