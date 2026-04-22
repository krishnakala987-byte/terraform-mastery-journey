resource "aws_instance" "server" {
  ami           = var.ami

  instance_type = var.env == "prod" ? var.instance_type : "t2.micro"

  tags = {
    Name = "${var.env}-server"
  }
}
