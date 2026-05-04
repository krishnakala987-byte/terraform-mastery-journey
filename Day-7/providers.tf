provider "aws" {
  region = "us-east-1"
}

provider "vault" {
  address = var.vault_addr

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.role_id
      secret_id = var.secret_id
    }
  }
}
