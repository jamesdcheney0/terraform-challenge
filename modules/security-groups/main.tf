resource "aws_security_group" "web_server" {
  name        = var.web_server_sg_name
  description = var.web_server_sg_description
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow traffic on port 80 from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.web_server_sg_name
  }
}

resource "aws_security_group" "bastion_ssh" {
  name        = var.bastion_ssh_sg_name
  description = var.bastion_ssh_sg_description
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow traffic on port 22 from local machine"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["98.168.57.5/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.bastion_ssh_sg_name
  }
}
