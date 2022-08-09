variable "aws_region" {
    description = "AWS region"
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