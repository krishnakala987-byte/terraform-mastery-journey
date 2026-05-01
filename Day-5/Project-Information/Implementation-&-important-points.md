## 1. Step-by-Step Implementation

### Step 1 – Project Structure

modules/
  vpc/
  ec2/

environments/dev/
scripts/
app/

---

### Step 2 – VPC Module

Create:
- VPC
- Subnet
- Internet Gateway
- Route Table

---

### Step 3 – EC2 Module

Create:
- Security group
- EC2 instance
- user_data

---

### Step 4 – Connect Modules

Use VPC outputs in EC2 module.

---

### Step 5 – OLD user_data (FAILED)

#!/bin/bash
apt update -y
apt install -y python3-pip
pip3 install flask
python3 app.py

Problem:
Flask installation failed (PEP 668)

---

### Step 6 – FINAL user_data (WORKING VERSION)

#!/bin/bash

set -e

apt update -y
apt install -y python3-pip python3-venv nginx

python3 -m venv /home/ubuntu/venv
source /home/ubuntu/venv/bin/activate

pip install flask

cat <<EOF > /home/ubuntu/app.py
from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Flask behind Nginx"

app.run(host="0.0.0.0", port=5000)
EOF

cd /home/ubuntu
nohup /home/ubuntu/venv/bin/python app.py > app.log 2>&1 &

cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;

    location / {
        proxy_pass http://127.0.0.1:5000;
    }
}
EOF

systemctl restart nginx

---

### Step 7 – Run Terraform

cd environments/dev

terraform init  
terraform plan  
terraform apply  

---

### Step 8 – Access App

http://<PUBLIC-IP>

---

## 2. Problems Faced & Troubleshooting

Problem: App not running  
Cause: Incomplete user_data  
Solution: Full script

---

Problem: Flask not installing  
Cause: PEP 668  
Solution: Virtual environment

---

Problem: Site not opening  
Cause: App not running  
Solution: Check logs + process

---

Problem: Wrong EC2  
Cause: Old IP  
Solution: Use terraform output

---

## 3. Mistakes & Things to Remember

- Do not use provisioners
- Always check logs
- Always verify running process
- Always use latest IP
- Destroy unused resources
- Use virtualenv
- Use Nginx

---

## 4. Quick Revision Summary

- Terraform → infra
- user_data → setup
- Flask → app
- Virtualenv → fix pip issue
- Nginx → production routing

Final Architecture:

User → Nginx → Flask → EC2 → VPC


# =========================
# TROUBLESHOOTING.md
# =========================

# Troubleshooting Guide

Check running process:
ps aux | grep python

Check logs:
cat /var/log/cloud-init-output.log

Fixes:
- App not running → check logs
- Flask missing → use virtualenv
- Site not opening → check SG
- Wrong IP → terraform output
