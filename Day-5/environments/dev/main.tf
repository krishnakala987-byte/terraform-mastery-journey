module "vpc" {
  source = "../../modules/vpc"
}

module "ec2" {
  source = "../../modules/ec2"

  subnet_id     = module.vpc.subnet_id
  vpc_id        = module.vpc.vpc_id
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
}

output "public_ip" {
  value = module.ec2.public_ip
}
