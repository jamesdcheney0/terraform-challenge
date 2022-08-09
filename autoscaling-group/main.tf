data "aws_ami" "rhel_8_5" {
  most_recent = true
  owners = ["309956199498"] 
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

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.rhel_8_5.id
  instance_type = var.asg_instance_type
  subnet_id              = var.public_subnet_1_id
  vpc_security_group_ids = var.bastion_ssh_sg
  root_block_device {
    volume_size = var.asg_volume_size
    volume_type = var.asg_volume_type
  }

  tags = {
    Name = var.asg_instance_name
  }
  
  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello World :)</div></body></html>" > /var/www/html/index.html
    EOF
}