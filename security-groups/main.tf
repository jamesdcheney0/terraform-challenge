resource "aws_security_group" "web_server" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow traffic on port 80 from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.ec2_security_group_name
  }
}

