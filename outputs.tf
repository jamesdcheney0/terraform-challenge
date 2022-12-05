output "instance_public_ip" {
  description = "Public IP of bastion instance"
  value       = module.bastion.instance_public_ip
}
