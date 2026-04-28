## 1. Step-by-Step Project Implementation

### Step 1: Create Modules Structure

```
modules/
  ├── ec2/
  ├── s3/
  ├── security_group/
```

---

### Step 2: Security Group Module

- Open ports:
  - 80 (HTTP)
  - 22 (SSH)

- SSH restricted using variable:
```hcl
cidr_blocks = [var.allowed_ssh_cidr]
```

---

### Step 3: EC2 Module

- Uses:
  - AMI
  - Instance type
  - Security group

- Installs NGINX using user_data

```bash
apt update -y
apt install nginx -y
```

- Custom HTML page:

```html
<h1>dev environment - Terraform Project</h1>
```

---

### Step 4: Elastic IP

Attached to EC2 for fixed public IP

---

### Step 5: S3 Module

Creates bucket using:

```hcl
bucket = var.bucket_name
```

---

### Step 6: Root main.tf

Connect all modules:

```hcl
module "security_group" {
  source = "./modules/security_group"
  env = var.env
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "ec2" {
  source = "./modules/ec2"
  ami = var.ami
  instance_type = var.instance_type
  env = var.env
  sg_id = module.security_group.sg_id
}

module "s3" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}
```

---

### Step 7: Backend Setup

S3 used for storing state

DynamoDB used for locking

---

## 2. Problems Faced & Troubleshooting

---

### Problem 1: Website not opening

Cause:
- NGINX not installed or started

Solution:
- Add user_data properly
- Check port 80 open

---

### Problem 2: Public IP not working

Cause:
- Security group issue

Solution:
- Allow HTTP (80) from 0.0.0.0/0

---

### Problem 3: No key pair attached

Cause:
- key_name not added

Solution:
- Add key_name in EC2 resource

---

### Problem 4: Backend bucket not found

Error:
```
S3 bucket does not exist
```

Solution:
- Create bucket manually before init

---

### Problem 5: DynamoDB deleted manually

Error:
```
Error acquiring state lock
```

Cause:
- Terraform trying to lock but table missing

Solution:
- Recreate DynamoDB table

---

### Problem 6: Missing required argument

Example:
```
key_name is required
```

Solution:
- Pass variable in root module

---

## 3. Mistakes & Things to Remember

- Never delete backend resources manually (S3 + DynamoDB)
- Always pass required variables to modules
- Keep modules independent
- Use outputs to connect modules
- Always run validate before apply
- Use proper naming (env-based)

Important:

- DynamoDB → for locking
- S3 → for storing state

---

## 4. Quick Revision Summary

- Modules = reusable Terraform code
- Each module has main.tf, variables.tf, outputs.tf
- Root module connects everything
- Inputs go in → variables
- Outputs come out → outputs.tf
- Security Group → passed to EC2
- Backend uses S3 + DynamoDB
- Always avoid manual changes in cloud

---

## Final Result

- EC2 created
- NGINX installed
- Custom web page working
- Elastic IP attached
- S3 bucket created
- Modules properly connected
- Backend configured

Project successfully completed
