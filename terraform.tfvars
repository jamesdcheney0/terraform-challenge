aws_region = "us-east-1"
aws_key_pair = "personal-aws-access"

ec2_instance_name = "bastion"
asg_instance_name = "web-server"
asg_name = "web-server-asg"
s3_bucket_name = "dev-bucket"
web_server_sg_name = "http-80-alb-sg"
bastion_ssh_sg_name = "ssh-22-bastion-sg"

web_server_sg_description = "Allows port 80 from all sources"
bastion_ssh_sg_description = "Allows port 22 from local Intel Mac"

ec2_instance_type = "t2.micro"
asg_instance_type = "t2.micro"

ec2_volume_size = "20"
asg_volume_size = "20"

asg_volume_type = "gp2"
ec2_volume_type = "gp2"
