output "public_ip" {
  description = "Public IP of EC2 instance"
  value       = aws_eip.elastic_ip.public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.server.id
}
