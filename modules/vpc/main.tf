resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"

  tags = {
    Name = "VPC-${var.env}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW-${var.env}"
  }
}


########## Public Subnets ##########

resource "aws_subnet" "public_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.availability_zones)
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone = element(var.availability_zones, count.index)

  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-${element(var.availability_zones, count.index)}-${var.env}"
  }
}

resource "aws_route_table" "public_subnets_route_table" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.availability_zones)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-Subnet-${element(var.availability_zones, count.index)}-rt-${var.env}"
  }
}

resource "aws_route_table_association" "public_subnets_rt_association" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_subnet_1_route_table.id
}

########## NAT Gateway ##########

resource "aws_eip" "nat_gateway_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  count         = length(var.availability_zones[0])
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)

  tags = {
    Name = "NAT-Gateway-${var.env}"
  }
}

########## Private Subnets ##########

resource "aws_subnet" "private_subnets" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.availability_zones)
  cidr_block        = cidrsubnet(var.cidr_block, 8, count.index + length(var.availability_zones))
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Private-Subnet-${element(var.availability_zones, count.index)}-${var.env}"
  }
}


resource "aws_route_table" "private_subnets_route_table" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.availability_zones)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "Private-Subnet-${element(var.availability_zones, count.index)}-rt-${var.env}"
  }
}

resource "aws_route_table_association" "private_subnet_1_rt_association" {
  count          = length(var.availability_zones)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private_subnet_1_route_table.id
}

