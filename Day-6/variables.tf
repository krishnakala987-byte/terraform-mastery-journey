variable "instance_type_map" {
  default = {
    dev  = "t2.micro"
    qa   = "t2.small"
    prod = "t2.medium"
  }
}