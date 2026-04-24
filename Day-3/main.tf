module "security_group" {
  source = "./modules/security_group"

  env              = var.env
  allowed_ssh_cidr = var.allowed_ssh_cidr   
}

module "ec2" {
  source = "./modules/ec2"

  ami           = var.ami
  instance_type = var.instance_type
  env           = var.env

  # connect SG → EC2
  sg_id = module.security_group.sg_id
}

module "s3" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
}
