resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = var.env == "prod" ? var.instance_type : "t2.micro"

  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>${var.env} environment</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.env}-server"
  }
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.server.id
}
