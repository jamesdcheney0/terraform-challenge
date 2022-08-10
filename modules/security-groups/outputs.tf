output "web_server_sg_id" {
  description = "ID of security group for web traffic"
  value = aws_security_group.web_server.id
}
output "bastion_ssh_sg_id" {
  description = "ID of security group for bastion SSH from local Intel Mac"
  value = aws_security_group.bastion_ssh.id
}
