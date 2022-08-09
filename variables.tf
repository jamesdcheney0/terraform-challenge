variable "aws_region" {
    description = "AWS region"
    type = string
}

variable "ec2_instance_type" {
    description = "Instance type for EC2 instance"
    type = string
}

variable "ec2_storage_size" {
    description = "Instance type for EC2 instance"
    type = string
}

variable "ASG_instance_type" {
    description = "Instance type for ASG instances"
    type = string
}

variable "asg_storage_size" {
    description = "Instance type for ASG instances"
    type = string
}