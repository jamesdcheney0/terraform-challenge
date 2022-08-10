variable "vpc_id" {
  description = "ID of the VPC to be launched in"
  type = string
}


variable "web_server_sg_name" {
  description = "Name of web server security group"
  type = string
}
variable "bastion_ssh_sg_name" {
  description = "Name of bastion SSH security group"
  type = string
}


variable "web_server_sg_description" {
  description = "Description of web server security group"
  type = string
}
variable "bastion_ssh_sg_description" {
  description = "Description of bastion SSH security group"
  type = string
}
