
output "public_ip" {
  description = "Public IP of EC2"
  value       = module.ec2_instance.public_ip
}

output "instance_state" {
  description = "Current state of EC2"
  value       = module.ec2_instance.instance_state
}

output "environment" {
  description = "Current workspace/environment"
  value       = terraform.workspace
}

output "public_url" {
  value = "http://${module.ec2_instance.public_ip}"
}