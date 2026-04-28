## 1. Introduction

Terraform modules are a way to organize and reuse code.

Instead of writing everything in one file, we split infrastructure into smaller reusable parts.

Real-world analogy:

Think of modules like functions in programming.
Instead of repeating code, you create once and reuse everywhere.

Example:
- EC2 setup → one module
- S3 bucket → one module
- Security group → one module

---

## 2. Core Concepts

### What is a Module?

A module is a folder that contains Terraform files:

- main.tf → actual resources
- variables.tf → inputs
- outputs.tf → outputs

---

### Why Modules?

- Reusability
- Clean code
- Easy maintenance
- Industry standard

---

### Module Flow

Root Module (main.tf)
        ↓
Calls Child Modules
        ↓
Passes variables
        ↓
Receives outputs

---

### Input Variables

Used to pass values into modules

Example:
```hcl
variable "ami" {
  type = string
}
```

---

### Outputs

Used to pass data from module to root or other modules

Example:
```hcl
output "public_ip" {
  value = aws_instance.server.public_ip
}
```

---

### Module Connection (Important)

Security Group → EC2

```hcl
sg_id = module.security_group.sg_id
```

This means:
- SG module creates SG
- EC2 module uses it

---

## 3. Important Commands

### Initialize

```bash
terraform init
```

Downloads providers and modules

---

### Validate

```bash
terraform validate
```

Checks syntax errors

---

### Format

```bash
terraform fmt -recursive
```

Formats all files

---

### Plan

```bash
terraform plan -var-file="dev.tfvars"
```

Shows what Terraform will create

---

### Apply

```bash
terraform apply -var-file="dev.tfvars"
```

Creates infrastructure

---

### Destroy

```bash
terraform destroy -var-file="dev.tfvars"
```

Deletes infrastructure

---
