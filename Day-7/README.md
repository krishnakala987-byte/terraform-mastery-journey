# Day 7 – HashiCorp Vault Integration with Terraform (AppRole Authentication)

## Overview

In this project, I integrated HashiCorp Vault with Terraform to securely manage and retrieve secrets using AppRole authentication. This setup eliminates hardcoded credentials and demonstrates a production-grade approach to secret management.

---

## Objectives

* Understand how Vault manages secrets
* Implement KV v2 secrets engine
* Create and apply Vault policies
* Configure AppRole authentication
* Integrate Vault with Terraform
* Securely fetch secrets inside Terraform execution

---

## Architecture

Terraform → AppRole Authentication → Vault → KV Secrets Engine → Secret Retrieval

---

## Step-by-Step Implementation

### 1. Start Vault Server

Vault was started using configuration file:

vault server -config=/etc/vault/config.hcl

Important:

* Listener configured on port 8200
* TLS disabled (HTTP used)
* Storage backend: file

---

### 2. Enable KV Secrets Engine

vault secrets enable -path=kv kv-v2

Purpose:

* Store secrets in structured format
* Versioning support (KV v2)

---

### 3. Store Secret in Vault

vault kv put kv/app db_username=admin db_password=supersecret

This created a secret at:
kv/data/app

---

### 4. Configure Vault Address

export VAULT_ADDR="http://127.0.0.1:8200"

Also added to ~/.bashrc for persistence.

---

### 5. Create Vault Policy

app-policy.hcl:

path "kv/data/app" {
capabilities = ["read"]
}

Command:

vault policy write app-policy app-policy.hcl

Purpose:

* Restrict access to only required path
* Enforce least privilege

---

### 6. Enable AppRole Authentication

vault auth enable approle

---

### 7. Create Role

vault write auth/approle/role/terraform-role token_policies="app-policy"

Purpose:

* Bind policy to role
* Define access permissions

---

### 8. Generate Credentials

vault read auth/approle/role/terraform-role/role-id
vault write -f auth/approle/role/terraform-role/secret-id

Outputs:

* role_id
* secret_id

These are required for Terraform authentication.

---

### 9. Terraform Configuration

Terraform used:

* Vault provider
* AppRole authentication
* Data source to read secret

Example:

data "vault_kv_secret_v2" "app" {
mount = "kv"
name  = "app"
}

resource "null_resource" "example" {
provisioner "local-exec" {
command = "echo DB Username is ${data.vault_kv_secret_v2.app.data["db_username"]}"
}
}

---

### 10. Terraform Execution

terraform init
terraform apply

Inputs:

* role_id
* secret_id
* vault_addr

---

## Final Outcome

* Terraform successfully authenticated with Vault
* Secret retrieved securely
* No credentials hardcoded
* Output hidden due to sensitive data handling

---

## Issues Faced and Troubleshooting

### 1. HTTPS vs HTTP Error

Issue:
http: server gave HTTP response to HTTPS client

Fix:
Set correct VAULT_ADDR with http://

---

### 2. Path Already Exists

Issue:
path is already in use

Fix:
KV engine was already enabled

---

### 3. Vault Sealed

Issue:
Vault is sealed

Fix:
Unsealed Vault or restarted properly

---

### 4. Connection Refused

Issue:
dial tcp 127.0.0.1:8200: connect: connection refused

Fix:
Vault server was not running or crashed due to low memory

---

### 5. Instance Resource Limitation

Issue:
Vault process killed automatically

Reason:
t2.micro has insufficient RAM

Fix:
Upgrade instance type (recommended: t2.small or higher)

---

### 6. Permission Denied

Issue:
permission denied while creating token

Fix:
Correct policy path to:
kv/data/app (not kv/app)

---

### 7. Terraform “No configuration files”

Issue:
Running Terraform from wrong directory

Fix:
Navigate to project folder before running commands

---

## Important Concepts Learned

* Authentication vs Authorization
* Vault policies enforce security boundaries
* AppRole is used for machine-to-machine authentication
* Secrets should never be hardcoded
* Terraform can securely consume external secrets

---

## Key Takeaways

* Vault provides centralized secret management
* AppRole is critical for automation workflows
* Proper policies are essential for secure access
* Debugging real-world DevOps issues builds strong understanding

---

## Future Improvements

* Use dynamic secrets (database credentials)
* Integrate Vault with AWS IAM authentication
* Automate with CI/CD pipelines
* Enable TLS for production use

---

## Conclusion

This project demonstrates a real-world implementation of secure secret management using Vault and Terraform. It highlights best practices such as least privilege access, external secret storage, and secure authentication mechanisms.

