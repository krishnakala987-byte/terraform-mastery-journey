variable "env" {
  description = "Environment (dev/prod)"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "Allowed IP for SSH access"
  type        = string
}
