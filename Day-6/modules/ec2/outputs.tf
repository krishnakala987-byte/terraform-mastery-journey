output "instance_id" {
    description = "ID of the EC2 Instance"
    value       = aws_instance.this.id
}

output "public_ip" {
    description = "Public IP of the EC2 Instance"
    value       = aws_instance.this.public_ip
}

output "private_ip" {
    description = "Private IP of the EC2 Instance"
    value       = aws_instance.this.private_ip
}

output "instance_state" {
    description = "State of the EC2 Instance"
    value       = aws_instance.this.instance_state
}