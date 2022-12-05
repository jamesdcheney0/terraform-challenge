data "aws_ami" "rhel_8_5" {
  most_recent = true
  owners      = ["309956199498"]
  filter {
    name   = "name"
    values = ["RHEL-8.5*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.rhel_8_5.id
  instance_type          = var.ec2_instance_type
  subnet_id              = var.public_subnet.id
  vpc_security_group_ids = [var.bastion_sg_id]
  key_name               = var.ec2_public_key
  root_block_device {
    volume_size = var.ec2_volume_size
    volume_type = var.ec2_volume_type
  }

  tags = {
    Name = "Bastion-${var.env}"
  }
}
