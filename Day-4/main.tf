resource "aws_instance" "my_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "day4-ec2"
    Env  = "dev"
  }
}
