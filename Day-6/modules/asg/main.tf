resource "aws_launch_template" "this" {
  name_prefix   = "lt-${terraform.workspace}"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.sg_id]
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    echo "<h1>${terraform.workspace} environment</h1>" > /var/www/html/index.html
  EOF
  )
}

resource "aws_autoscaling_group" "this" {
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = var.subnets

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  target_group_arns = [var.target_group_arn]
}