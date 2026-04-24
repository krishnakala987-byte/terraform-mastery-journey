variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "Instance type for prod"
  type        = string
}

variable "env" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "ami" {
  description = "AMI ID"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "Allowed IP for SSH"
  type        = string
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}
