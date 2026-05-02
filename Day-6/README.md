# Terraform Multi-Environment Infrastructure with Workspaces + Modules + ALB + ASG

## Overview

This project demonstrates how to build production-style infrastructure using Terraform with:

- Workspaces for environment separation (dev, qa, prod)
- Modular architecture
- Remote backend (S3 + DynamoDB)
- Custom VPC networking
- Security Groups
- EC2 + Auto Scaling Group (ASG)
- Application Load Balancer (ALB)

The same Terraform code dynamically creates isolated infrastructure for multiple environments without duplication.

---

## Architecture

User → ALB → Target Group → Auto Scaling Group → EC2 Instances → VPC → Subnets

Each environment (dev, qa, prod) has:
- Separate state file
- Separate infrastructure
- Different instance sizes

---

## Key Concepts Implemented

### 1. Terraform Workspaces

Used to manage multiple environments:

- dev
- qa
- prod

Each workspace creates:
- Separate infrastructure
- Separate state file

Command examples:

```
terraform workspace new dev
terraform workspace select qa
terraform workspace show
```

---

### 2. Dynamic Configuration

Used:

- terraform.workspace
- lookup()

Example:

```
instance_type = lookup(var.instance_type_map, terraform.workspace)
```

This allows:
- dev → small instance
- qa → medium instance
- prod → large instance

---

### 3. Modular Structure

Reusable modules:

```
modules/
├── vpc/
├── security_group/
├── ec2/
├── alb/
├── asg/
```

Benefits:
- Reusability
- Clean code
- Production-ready structure

---

### 4. Custom VPC

- VPC creation
- Public subnets (Multi-AZ)
- Internet Gateway
- Route tables

Important:
ALB requires at least 2 subnets in different AZs.

---

### 5. Security Group

- Allow HTTP (80)
- Allow SSH (22)

---

### 6. EC2 + User Data

EC2 instances are configured using user_data:

```
#!/bin/bash
apt update
apt install -y nginx
systemctl start nginx
echo "$(terraform.workspace) environment" > /var/www/html/index.html
```

This ensures:
- No manual setup
- Fully automated provisioning

---

### 7. Auto Scaling Group (ASG)

- Maintains desired number of instances
- Automatically replaces unhealthy instances

---

### 8. Application Load Balancer (ALB)

- Distributes traffic across instances
- Connected to ASG via target group

---

### 9. Remote Backend (S3 + DynamoDB)

State stored in S3:
- Safe
- Centralized

DynamoDB:
- State locking
- Prevents conflicts

---

## Outputs

```
terraform output alb_url
```

Example:

```
http://<alb-dns>
```

---

## Project Workflow

1. Initialize Terraform

```
terraform init
```

2. Create workspace

```
terraform workspace new dev
```

3. Apply infrastructure

```
terraform apply -auto-approve
```

4. Get URL

```
terraform output alb_url
```

---

## Important Learnings

- Never use single state for multiple environments
- Workspaces prevent accidental infra destruction
- Always design modules for reusability
- ALB requires multiple AZ subnets
- Avoid manual changes — use user_data
- Remote backend is mandatory for real-world usage

---

## Common Issues Faced

### 1. ALB creation failed

Cause:
- Only 1 subnet

Fix:
- Add 2 subnets in different AZs

---

### 2. Destroy stuck

Cause:
- Dependency chain (ALB → ASG → EC2 → subnet)

Temporary Fix:
```
terraform destroy -target=module.asg
terraform destroy -target=module.alb
terraform destroy
```

Better approach:
- Proper dependency handling

---

### 3. Nginx not working

Cause:
- user_data not executed properly

Fix:
- Ensure correct script
- Check logs: /var/log/cloud-init-output.log

---

## Final Result

- Multi-environment infrastructure
- Fully automated setup
- Load-balanced application
- Production-like architecture

---

## Author

Built as part of Terraform Mastery Journey.
