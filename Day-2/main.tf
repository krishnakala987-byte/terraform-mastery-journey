# Security Group
resource "aws_security_group" "web_sg" {
  name = "${var.env}-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.env}-sg"
  }
}

#  EC2 Instance
resource "aws_instance" "server" {
  ami = var.ami

  instance_type = var.env == "prod" ? var.instance_type : "t2.micro"
  
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = "ansible-demo"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF

  tags = {
    Name = "${var.env}-server"
  }
}

#  S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "${var.env}-bucket"
  }
}
