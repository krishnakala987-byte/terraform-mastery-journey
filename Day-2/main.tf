resource "aws_security_group" "web_sg" {
  name = "${var.env}-sg"

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.env == "prod" ? var.instance_type : "t2.micro"

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>${var.env} environment - Terraform Project</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.env}-server"
  }
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.server.id
}
