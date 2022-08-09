output "instance_public_ip" {
    description = "Public IP of EC2 instance"
    value = module.ec2.instance_public_ip
}