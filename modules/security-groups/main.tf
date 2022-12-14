resource "aws_security_group" "web_server" {
  name        = "${var.env}-HTTP-sg"
  description = "${var.env} web server HTTP security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow traffic on port 80 from everywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web-server-80-SG-${var.env}"
  }
}

resource "aws_security_group" "bastion_ssh" {
  name        = "${var.env}-bastion-SSH-sg"
  description = "${var.env} Bastion SSH security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow traffic on port 22 from local machine"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["98.168.57.5/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion-SSH-SG-${var.env}"
  }
}
