variable "aws_az_1" {
    description = "Availability zone 1 for resources to use"
    type = string
    default = "us-east-1"
}
variable "aws_az_2" {
    description = "Availability zone 2 for resources to use"
    type = string
    default = "us-east-2"
}

variable "vpc_name" {
    description = "Name of VPC"
    type = string
    default = "dev-vpc"
}
variable "igw_name" {
    description = "Internet Gateway for VPC"
    type = string
    default = "dev-igw"
}
variable "nat_gateway_name" {
    description = "NAT gateway for VPC"
    type = string
    default = "dev-nat"
}


variable "public_subnet_1_name" {
    description = "Name for first public subnet"
    type = string
    default = "dev-public-subnet-1"
}
variable "public_subnet_2_name" {
    description = "Route table for second public subnet"
    type = string
    default = "dev-public-rt-2"
}
variable "private_subnet_1_name" {
    description = ""
    type = string
    default = ""
}
variable "private_subnet_2_name" {
    description = ""
    type = string
    default = ""
}



variable "public_subnet_1_cidr_block" {
    description = "CIDR block for first public subnet"
    type = string
    default = "dev-public-subnet-2"
}
variable "public_subnet_2_cidr_block" {
    description = "CIDR block for second subnet"
    type = string
    default = ""
}
variable "private_subnet_1_cidr_block" {
    description = ""
    type = string
    default = ""
}
variable "private_subnet_2_cidr_block" {
    description = ""
    type = string
    default = ""
}
variable "vpc_cidr_block" {
    description = "CIDR block for VPC"
    type = string
    default = "10.1.0.0/16"
}



variable "public_subnet_1_rt_name" {
    description = "Route table for first public subnet"
    type = string
    default = "dev-public-rt-1"
}
variable "public_subnet_2_rt_name" {
    description = "Route table for second public subnet"
    type = string
    default = ""
}
variable "private_subnet_1_rt_name" {
    description = ""
    type = string
    default = ""
}
variable "private_subnet_2_rt_name" {
    description = ""
    type = string
    default = ""
}

