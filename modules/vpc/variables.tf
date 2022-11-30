variable "availability_zones" {
  description = "Availability zones in region"
  type        = list(string)
}

variable "env" {
  description = "What is the purpose of the environment?"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
}