resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
#!/bin/bash
apt-get update -y
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx
echo "<h1>${terraform.workspace} environment</h1>" > /var/www/html/index.html
EOF

  tags = {
    Name = "${var.name}-${terraform.workspace}"
  }
}
