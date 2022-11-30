output "instance_public_ip" {
  description = "Public IP of EC2 instance"
  value       = module.aws_ec2.instance_public_ip
}
