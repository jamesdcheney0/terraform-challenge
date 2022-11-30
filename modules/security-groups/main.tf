resource "aws_security_group" "web_server" {
  name        = var.web_server_sg_name
  description = "${var.env} web server HTTP security group"
  vpc_id      = module.vpc.vpc_id

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
  depends_on = [
    module.vpc
  ]
}

resource "aws_security_group" "bastion_ssh" {
  name        = var.bastion_ssh_sg_name
  description = "${var.env} Bastion SSH security group"
  vpc_id      = module.vpc.vpc_id

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
  depends_on = [
    module.vpc
  ]
}
