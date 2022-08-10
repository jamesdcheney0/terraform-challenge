resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.aws_az_1

  tags = {
    Name = var.public_subnet_1_name
  }
}


resource "aws_route_table" "public_subnet_1_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_subnet_1_rt_name
  }
}

resource "aws_route_table_association" "public_subnet_1_rt_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_subnet_1.id
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_2_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.aws_az_2

  tags = {
    Name = var.public_subnet_2_name
  }
}


resource "aws_route_table" "public_subnet_2_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.public_subnet_2_rt_name
  }
}

resource "aws_route_table_association" "public_subnet_2_rt_association" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_subnet_2.id
}

resource "aws_nat_gateway" "nat_gateway" {
    subnet_id = aws_subnet.public_subnet_1

    tags = {
        Name = var.nat_gateway_name
    }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_1_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.aws_az_1

  tags = {
    Name = var.private_subnet_1_name
  }
}


resource "aws_route_table" "private_subnet_1_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = var.private_subnet_1_rt_name
  }
}

resource "aws_route_table_association" "private_subnet_1_rt_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_subnet_1.id
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_2_cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.aws_az_2

  tags = {
    Name = var.private_subnet_2_name
  }
}


resource "aws_route_table" "private_subnet_2_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = var.private_subnet_2_rt_name
  }
}

resource "aws_route_table_association" "private_subnet_2_rt_association" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_subnet_2.id
}