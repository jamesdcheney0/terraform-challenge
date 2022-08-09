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

resource "aws_launch_configuration" "asg_configuration" {
  name = var.ec2_instance_name
  ami = data.aws_ami.rhel_8_5.id
  instance_type = var.ec2_instance_type
  key_name = var.ec2_public_key

  tags = {
    Name = var.ec2_instance_name
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

resource "aws_autoscaling_group" "web_server_asg" {
  name = var.asg_name
  max_size = var.asg_max_size
  min_size = var.asg_min_size
  health_check_grace_period = 30
  health_check_type = "EC2"
  force_delete = ["OldestInstance"]
  launch_configuration = aws_launch_configuration.asg_configuration.name
  vpc_zone_identifier = [var.private_subnet_1_id, var.private_subnet_2_id]
}

resource "aws_autoscaling_policy" "web_server_asg_policy" {
    name = "${var.asg_name}-policy"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = aws_autoscaling_group.web_server_asg.name
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
    alarm_name = "${var.asg_name}-alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = AWS/EC2
    period = "60"
    statistic = "Average"
    threshold = "10"
    alarm_actions = [
        "${aws_autoscaling_policy.web_server_asg_policy.arn}"
    ]
    dimensions = {
        AutoScalingGroupName = "${aws_autoscling_group.web_server_asg.name}"
    }
}