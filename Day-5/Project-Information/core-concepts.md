# Day 5 – Terraform Provisioners to Production Deployment

---

## 1. Introduction

This day was focused on deploying a real application using Terraform.

Instead of just creating infrastructure, I learned how to:
- Deploy an app automatically
- Debug failures
- Improve setup to match real industry practices

Real-world analogy:
Terraform builds the house (infrastructure), and user_data sets everything inside automatically (software + app).

---

## 2. Core Concepts

### Provisioners vs user_data

Provisioners:
- Run after resource creation
- Require SSH
- Not reliable in production

user_data:
- Runs during EC2 startup
- No SSH required
- Industry standard

Conclusion:
Always prefer user_data over provisioners.

---

### Infrastructure Components

- VPC → network
- Subnet → where EC2 lives
- Internet Gateway → internet access
- Route Table → routing
- Security Group → firewall
- EC2 → server

---

### Flask Deployment

- Flask runs backend
- Initially exposed on port 5000

---

### Virtual Environment (IMPORTANT)

Problem:
pip install flask failed due to:
externally-managed-environment (PEP 668)

Reason:
Ubuntu blocks global pip installs.

Solution:
Use virtual environment:

python3 -m venv venv

This creates isolated environment for dependencies.

---

### Nginx Reverse Proxy

Instead of:
User → Flask (5000)

We use:
User → Nginx (80) → Flask (5000)

Benefits:
- Clean URL
- Security
- Production standard

---

## 3. Important Commands

Terraform:

terraform init  
terraform plan  
terraform apply  
terraform destroy  
terraform output public_ip  

---

Debugging:

ps aux | grep python  
cat /var/log/cloud-init-output.log  

---

SSH:

ssh -i key.pem ubuntu@<IP>
